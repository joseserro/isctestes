package Site;

import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import sun.net.www.protocol.mailto.MailToURLConnection;

public class DBUtil {
	
	/// FUNCAO RETIRADA DA INTERNET PARA ENCRIPTACAO DA PASSWORD (LOGIN & SIGNUP) ///
	public static String SHA256(String password){
        MessageDigest md;
		try {
			md = MessageDigest.getInstance("SHA-256");
	        md.update(password.getBytes());
	        byte[] byteData = md.digest();
	
	        StringBuilder hexString = new StringBuilder();
	        for (int i = 0; i < byteData.length; i++) {
	            String hex = Integer.toHexString(0xff & byteData[i]);
	            if (hex.length() == 1)
	                hexString.append('0');
	            hexString.append(hex);
	        }
	        return hexString.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return "";
    }
	
	public static String encodeHTML(String s) {
	    StringBuffer out = new StringBuffer();
	    for(int i=0; i<s.length(); i++) {
	        char c = s.charAt(i);
	        if(c > 127 || c=='"' || c=='<' || c=='>') {
	           out.append("&#"+(int)c+";");
	        } else {
	            out.append(c);
	        }
	    }
	    return out.toString();
	}

	/// VERIFICA SE UM UTILIZADOR EXISTE NA BASE DE DADOS (LOGIN) ///
	public static boolean userExistsOnDB(String email, String password) throws SQLException, NoSuchAlgorithmException {
		Statement link = DBAuth.establishConnectionToDB();
		ResultSet rs = link.executeQuery(
				"SELECT * FROM Utilizadores WHERE Email='"+email+"' AND Password='"+password+"';");
		if(rs.next()) {
			if(email.equals(rs.getString("Email")) && (password.equals(rs.getString("Password")))) {
				link.close();
				//closeConnections();
				return true;
			}
		}
		link.close();
		//closeConnections();
		return false;
	}
	
	/// VERIFICA SE UM EMAIL EXISTE NA BASE DE DADOS (SIGNUP) ///
	public static boolean emailExistsOnDB(String email) throws SQLException {
		Statement link = DBAuth.establishConnectionToDB();
		ResultSet rs = link.executeQuery(
				"SELECT * FROM Utilizadores WHERE Email='"+email+"';");
		if(rs.next()) {
			if(email.equals(rs.getString("Email"))) {
				link.close();
				//closeConnections();
				return true;
			}
		}
		link.close();
		//closeConnections();
		return false;
	}
	
	/// FUNCAO QUE GRAVA UM UTILIZADOR NA BASE DE DADOS (SIGNUP)
	public static void saveSignupInfo(String primeiroNome, String ultimoNome, String email, 
			String password, int cursoID, int ano, String tipo, String status){
		try{
			Statement link = DBAuth.establishConnectionToDB();
			password = SHA256(password);
			String imgUrl = "http://placehold.it/250x250";
			String passkey = SHA256(email);
			String desc = "Eu sou um estudante do ISCTE.";
			link.executeUpdate(
			"INSERT INTO Utilizadores (PrimeiroNome, UltimoNome, Email, Password, Curso, Ano, Tipo, Status, Img, Desc, PassKey) VALUES " +
			"('"+primeiroNome+"', '"+ultimoNome+"', '"+email+"','"+password+"','"+cursoID+"','"+ano+"', '"+tipo+"','"+status+"','"+imgUrl+"','"+desc+"','"+passkey+"')");
		
			link.close();
			//closeConnections();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//// CONFIRMAR O EMAIL ENVIADO ////
	public static boolean confirmEmail(String passkey) throws SQLException{
		Statement link = DBAuth.establishConnectionToDB();
		ResultSet rs = link.executeQuery("SELECT * FROM Utilizadores WHERE PassKey = '"+passkey+"';");
		if(rs.next()){
			link.execute("UPDATE Utilizadores SET Status = 'active' WHERE ID = '"+rs.getInt("ID")+"';");
			return true;
		}
		return false;
	}
	
	public static void banUser(int id) throws SQLException{
		Statement link = DBAuth.establishConnectionToDB();
		link.execute("UPDATE Utilizadores SET Status = 'banned' WHERE ID = '"+id+"';");
	}
	
	//// FUNCAO QUE GUARDA O CONTEUDO QUE FOI ENVIADO NA BASE DE DADOS ////
	public static void saveContentInfo(String cadeira, String link, String titulo, 
		String descricao, int ano, int tipo, int epoca, int resolucao, int userID) throws SQLException {		
		int cadeiraID = DBInfo.getCadeiraID(cadeira);
		Statement dblink = DBAuth.establishConnectionToDB();
		
		dblink.executeUpdate(
			"INSERT INTO Conteudo (CadeiraID, Titulo, Link, Descricao, Ano, Tipo, Epoca, Resolucao, Likes, Reports, Hits, UserID) VALUES " +
			"('"+cadeiraID+"', '"+titulo+"', '"+link+"','"+descricao+"','"+ano+"','"+tipo+"','"+epoca+"','"+resolucao+"', '0', '0', '0', '"+userID+"')");
		
		dblink.close();
//		DBAuth.closeConnections();
	}
	
	//// FUNCAO QUE RETORNA UMA LISTA DE LISTAS QUE CONTÉM A INFO DO CONTEUDO ////
	public static ArrayList<ArrayList<String>> getContentByAnoTipoCadeira(int ano, int tipo, int cID) throws SQLException {
		ArrayList<ArrayList<String>> listOut = new ArrayList<ArrayList<String>>();
		Statement dblink = DBAuth.establishConnectionToDB();
		ResultSet rs = dblink.executeQuery("SELECT * FROM Conteudo WHERE Conteudo.Ano == '"+ano+"' AND Conteudo.Tipo == '"+tipo+"' AND Conteudo.CadeiraID == '"+cID+"';");
		
		while(rs.next()) {
			ArrayList<String> listIn = new ArrayList<String>();
			listIn.add(rs.getString("ID"));
			listIn.add(rs.getString("CadeiraID"));
			listIn.add(rs.getString("Titulo"));
			listIn.add(rs.getString("Link"));
			listIn.add(rs.getString("Descricao"));
			listIn.add(rs.getString("Ano"));
			listIn.add(rs.getString("Tipo"));
			listIn.add(rs.getString("Epoca"));
			listIn.add(rs.getString("Resolucao"));
			listIn.add(rs.getString("Likes"));
			listIn.add(rs.getString("Reports"));
			listIn.add(rs.getString("Hits"));
			listIn.add(rs.getString("UserID"));
			
			listOut.add(listIn);
		}
		dblink.close();
//		DBAuth.closeConnections();
		return listOut;
	}
	
	/// metodo que devolve o conteudo baseado no id do mesmo ////
	public static ArrayList<String> getContent(int idContent) throws SQLException{
		Statement dblink = DBAuth.establishConnectionToDB();
		ResultSet rs = dblink.executeQuery("SELECT * FROM Conteudo WHERE ID = '"+idContent+"';");
		ArrayList<String> listIn = new ArrayList<String>();
		if(rs.next()){
			listIn.add(rs.getString("ID"));
			listIn.add(rs.getString("CadeiraID"));
			listIn.add(rs.getString("Titulo"));
			listIn.add(rs.getString("Link"));
			listIn.add(rs.getString("Descricao"));
			listIn.add(rs.getString("Ano"));
			listIn.add(rs.getString("Tipo"));
			listIn.add(rs.getString("Epoca"));
			listIn.add(rs.getString("Resolucao"));
			listIn.add(rs.getString("Likes"));
			listIn.add(rs.getString("Reports"));
			listIn.add(rs.getString("Hits"));
			listIn.add(rs.getString("UserID"));
		}
		dblink.close();
		return listIn;
	}
	
	/// metodo que devolve todos os comments de um conteudo ////
		public static ArrayList<ArrayList<String>> getComments(int idContent) throws SQLException{
			ArrayList<ArrayList<String>> listOut = new ArrayList<ArrayList<String>>();
			Statement dblink = DBAuth.establishConnectionToDB();
			ResultSet rs = dblink.executeQuery("SELECT * FROM Comentarios WHERE ConteudoID = '"+idContent+"';");
			while(rs.next()){
				ArrayList<String> listIn = new ArrayList<String>();
				listIn.add(rs.getString("ID"));
				listIn.add(rs.getString("UserID"));
				listIn.add(rs.getString("Comentario"));
				listIn.add(rs.getString("Data"));
				listIn.add(""+idContent);
				
				listOut.add(listIn);
			}
			dblink.close();
			return listOut;
		}
		
	//// metodo que devolve o id da cadeira dado o comentario ////
		public static int getCadeiraID(int idContent){
			return 0;
		}
	
	//// FUNCAO TOSTRING DO TIPO ////
	public static String getStringFromTipo(String tipo) {
		if(tipo.equals("0")) {
			return "Exame";
		} else if(tipo.equals("1")) {
			return "Frequência";
		} else if(tipo.equals("2")) {
			return "Teste";
		} else if(tipo.equals("3")) {
			return "Trabalho";
		} else if(tipo.equals("4")) {
			return "Explicação";
		}
		return "Erro!";
	}
	
	//// FUNCAO TOSTRING DA ÉPOCA ////
	public static String getStringFromEpoca(String epoca) {
		if(epoca.equals("0")) {
			return "1ª Época";
		} else if(epoca.equals("1")) {
			return "2ª Época";
		} else if(epoca.equals("2")) {
			return "Época Especial";
		} 
		return "Erro!";
	}
	
	//// FUNCAO QUE DEVOLVE O NOME INTEIRO DO UTILIZADOR, DADO O SEU ID ////
	public static String getFullNameFromID(String userID) throws SQLException {
		Statement dblink = DBAuth.establishConnectionToDB();
		ResultSet rs = dblink.executeQuery("SELECT * FROM Utilizadores WHERE Utilizadores.ID == '"+userID+"';");
		
		if(rs.next()) {
			String fullName = rs.getString("PrimeiroNome")+" "+rs.getString("UltimoNome");
			dblink.close();
			return fullName;
		}
		dblink.close();
//		DBAuth.closeConnections();
		return "Erro";
	}
	
	public static int getNumberComments(int idContent) throws SQLException{
		Statement dblink = DBAuth.establishConnectionToDB();
		ResultSet rs = dblink.executeQuery("SELECT * FROM Comentarios WHERE ConteudoID == '"+idContent+"';");
		int num = 0;
		while(rs.next()) {
			num++;
		}
		dblink.close();
		return num;
	}

	/// FUNCAO QUE FAZ UPDATE AOS HITS ///
	public static void updateHits(int ID) throws SQLException{
		Statement dblink = DBAuth.establishConnectionToDB();
		ResultSet rs = dblink.executeQuery("SELECT * FROM Conteudo WHERE ID = '"+ID+"'");
		if(rs.next()){
			int num = rs.getInt("Hits");
			dblink.execute("UPDATE Conteudo SET Hits = '"+(num+1)+"' WHERE ID = '"+ID+"';");
		}
		dblink.close();
	}
	
	public static boolean hasLiked(int ID, int userID) throws SQLException{
		Statement dblink = DBAuth.establishConnectionToDB();
		ResultSet rsLikes = dblink.executeQuery("SELECT * FROM Likes WHERE ConteudoID = '"+ID+"' AND UserID = '"+userID+"';");
		boolean result = rsLikes.next();
		dblink.close();
		return result;
	}
	
	public static void addLikes(int ID, int userID) throws SQLException{
		Statement dblink = DBAuth.establishConnectionToDB();
		ResultSet rsLikes = dblink.executeQuery("SELECT * FROM Likes WHERE ConteudoID = '"+ID+"' AND UserID = '"+userID+"';");
		if(!rsLikes.next()){
			ResultSet rs = dblink.executeQuery("SELECT * FROM Conteudo WHERE ID = '"+ID+"'");
			if(rs.next()){
				int num = rs.getInt("Likes");
				dblink.execute("UPDATE Conteudo SET Likes = '"+(num+1)+"' WHERE ID = '"+ID+"';");
				dblink.execute("INSERT INTO Likes (ConteudoID, UserID) VALUES ("+ID+","+userID+");");
			}
		}
		dblink.close();
	}
	
	public static void remLikes(int ID, int userID) throws SQLException{
		Statement dblink = DBAuth.establishConnectionToDB();
		ResultSet rsLikes = dblink.executeQuery("SELECT * FROM Likes WHERE ConteudoID = '"+ID+"' AND UserID = '"+userID+"';");
		if(rsLikes.next()){
			ResultSet rs = dblink.executeQuery("SELECT * FROM Conteudo WHERE ID = '"+ID+"'");
			if(rs.next()){
				int num = rs.getInt("Likes");
				dblink.execute("UPDATE Conteudo SET Likes = '"+(num-1)+"' WHERE ID = '"+ID+"';");
				dblink.execute("DELETE FROM Likes WHERE ConteudoID = '"+ID+"' AND UserID = '"+userID+"';");
			}
		}
		dblink.close();
	}
	
	public static boolean hasReported(int ID, int userID) throws SQLException{
		Statement dblink = DBAuth.establishConnectionToDB();
		ResultSet rsLikes = dblink.executeQuery("SELECT * FROM Reports WHERE ConteudoID = '"+ID+"' AND UserID = '"+userID+"';");
		boolean result = rsLikes.next();
		dblink.close();
		return result;
	}
	
	public static void readMessage(int mid) throws SQLException{
		Statement dblink = DBAuth.establishConnectionToDB();
		dblink.execute("UPDATE Mensagens SET Status = '1' WHERE ID = '"+mid+"';");
		dblink.close();
	}
	
	public static void deleteMessage(int mid) throws SQLException{
		Statement dblink = DBAuth.establishConnectionToDB();
		dblink.execute("DELETE FROM Mensagens WHERE ID = '"+mid+"';");
		dblink.close();
	}
	
	public static void deleteContent(int cid) throws SQLException{
		Statement dblink = DBAuth.establishConnectionToDB();
		dblink.execute("DELETE FROM Conteudo WHERE ID = '"+cid+"';");
		dblink.close();
	}
	
	public static void deleteComment(int comid) throws SQLException{
		Statement dblink = DBAuth.establishConnectionToDB();
		dblink.execute("DELETE FROM Comentarios WHERE ID = '"+comid+"';");
		dblink.close();
	}
	
	public static void deleteUser(int uid) throws SQLException {
		Statement dblink = DBAuth.establishConnectionToDB();
		dblink.execute("DELETE FROM Utilizadores WHERE ID = '"+(uid)+"';");
		dblink.close();
	}
	
	
	
	public static void updateReports(int ID, int userID) throws SQLException{
		Statement dblink = DBAuth.establishConnectionToDB();
		ResultSet rsLikes = dblink.executeQuery("SELECT * FROM Reports WHERE ConteudoID = '"+ID+"' AND UserID = '"+userID+"';");
		if(!rsLikes.next()){
			ResultSet rs = dblink.executeQuery("SELECT * FROM Conteudo WHERE ID = '"+ID+"'");
			if(rs.next()){
				int num = rs.getInt("Reports");
				dblink.execute("UPDATE Conteudo SET Reports = '"+(num+1)+"' WHERE ID = '"+ID+"';");
				dblink.execute("INSERT INTO Reports (ConteudoID, UserID) VALUES ("+ID+","+userID+");");
			}
		}
		dblink.close();
	}
	
	
	// SEND AN EMAIL
	
	public static void sendMail(String from, String to, String subject, String body, String[] headers) throws IOException {
	   System.setProperty("mail.host", "zpankr.net");

	   URL u = new URL("mailto:"+to);
	   MailToURLConnection con = (MailToURLConnection)u.openConnection();
	   OutputStream os = con.getOutputStream();
	   OutputStreamWriter w = new OutputStreamWriter(os);

	   DateFormat df = new SimpleDateFormat("E, d MMM yyyy H:mm:ss Z");
	   Date d = new Date();
	   String dt = df.format(d);
	   String mid = d.getTime()+from.substring(from.indexOf('@'));

	   w.append("Subject: "+subject+"\r\n");
	   w.append("Date: " +dt+ "\r\n");
	   w.append("Message-ID: <"+mid+ ">\r\n");
	   w.append("From: "+from+"\r\n");
	   w.append("To: <"+to+">\r\n");
	   if(headers!=null) {
	      for(String h: headers)
	         w.append(h).append("\r\n");
	   }
	   w.append("\r\n");

	   w.append(body.replace("\n", "\r\n"));
	   w.flush();
	   w.close();
	   os.close();
	   con.close();
	}

	public static boolean cursoExists(int cursoID) throws SQLException {
		ArrayList<String> cursos = DBInfo.getAllCursos();
		if(cursoID > 1 && cursoID <= cursos.size()){
			return true;
		}
		return false;
	}

	public static void updateProfile(String passactual, String passnova, int ID, String imglink, int cursoID, int ano, String desc) throws SQLException {
		Statement dblink = DBAuth.establishConnectionToDB();
		ResultSet rs = dblink.executeQuery("SELECT Password FROM Utilizadores WHERE ID = '"+ID+"';");
		if(rs.next()){
			String curPass = rs.getString("Password");
			String shaPass = SHA256(passactual);
			if(curPass.equals(shaPass)){
				if(!imglink.equals("") && !imglink.equals(null)){
					dblink.execute("UPDATE Utilizadores SET Img = '"+imglink+"' WHERE ID = '"+ID+"';");
				}
				if(!passactual.equals(passnova) && !passnova.equals(null) && !passnova.equals("")){
					if(passnova.length() >= 6 && passnova.length() < 32){
						dblink.execute("UPDATE Utilizadores SET Password = '"+SHA256(passnova)+"' WHERE ID = '"+ID+"';");
					}
				}
				dblink.execute("UPDATE Utilizadores SET Curso = '"+cursoID+"', Ano = '"+ano+"', Desc = '"+desc+"' WHERE ID = '"+ID+"';");
			}
		}
		dblink.close();
	}

	public static void newComment(int userId, String comment, String data, int conteudoId) throws SQLException {
		Statement dblink = DBAuth.establishConnectionToDB();
		dblink.execute("INSERT INTO Comentarios (UserID, Comentario, Data, ConteudoID) VALUES ('"+userId+"','"+comment+"','"+data+"','"+conteudoId+"');");
		dblink.close();
	}

	public static void storeMessage(String contactNome, String contactEmail, String contactMessage) throws SQLException {
		Statement dblink = DBAuth.establishConnectionToDB();
		dblink.execute("INSERT INTO Mensagens (Nome, Email, Msg, Status) VALUES ('"+contactNome+"','"+contactEmail+"','"+contactMessage+"','0');");
		dblink.close();
	}
	
	public static boolean isAdmin(int userID) throws SQLException{
		Statement dblink = DBAuth.establishConnectionToDB();
		ResultSet rs = dblink.executeQuery("SELECT Tipo FROM Utilizadores WHERE ID = '"+userID+"' AND Tipo = 'admin';");
		if(rs.next()){
			dblink.close();
			return true;
		}
		dblink.close();
		return false;
	}

}
