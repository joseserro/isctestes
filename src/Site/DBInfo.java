package Site;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class DBInfo {
	
	/// FUNCAO QUE RETORNA O NOME COMPLETO A PARTIR DA BASE DE DADOS ///
	public static String getUserNameFromEmail(String email) throws SQLException {
		Statement link = DBAuth.establishConnectionToDB();
		ResultSet rs = link.executeQuery(
				"SELECT * FROM Utilizadores WHERE Email='"+email+"';");
		
		String firstName = "";
		String lastName = "";
		
		if(rs.next()) {
			firstName = rs.getString("PrimeiroNome");
			lastName = rs.getString("UltimoNome");
		}
		link.close();
		//DBAuth.closeConnections();
		return firstName+" "+lastName;
	}
	
	/// FUNCAO QUE RETORNA O NOME COMPLETO A PARTIR DA BASE DE DADOS ///
		public static String getUserName(int ID) throws SQLException {
			Statement link = DBAuth.establishConnectionToDB();
			ResultSet rs = link.executeQuery(
					"SELECT * FROM Utilizadores WHERE ID='"+ID+"';");
			
			String firstName = "";
			String lastName = "";
			
			if(rs.next()) {
				firstName = rs.getString("PrimeiroNome");
				lastName = rs.getString("UltimoNome");
			}
			link.close();
			//DBAuth.closeConnections();
			return firstName+" "+lastName;
		}
	
	/// FUNCAO QUE LISTA TODOS OS CURSOS PRESENTES NA BASE DE DADOS ///
	public static ArrayList<String> getAllCursos() throws SQLException {
		ArrayList<String> list = new ArrayList<String>();
		Statement link = DBAuth.establishConnectionToDB();
		ResultSet rs = link.executeQuery("SELECT * FROM Cursos;");
		
		while(rs.next()) {
			list.add(rs.getString("Designacao"));
		}
		link.close();
//		DBAuth.closeConnections();
		return list;
		
	}
	
	public static int getNumUsers() throws SQLException{
		Statement link = DBAuth.establishConnectionToDB();
		ResultSet rs = link.executeQuery("SELECT * FROM Utilizadores;");
		int num = 0;
		while(rs.next()){
			num++;
		}
		link.close();
		return num;
	}
	
	/// FUNCAO QUE LISTA TODAS CADEIRAS, DADO UM CURSO ///
	public static ArrayList<String> getAllCadeirasFromCurso(String nomeCurso) throws SQLException {
		ArrayList<String> list = new ArrayList<String>();
		Statement link = DBAuth.establishConnectionToDB();
		ResultSet rs = link.executeQuery("SELECT Cadeiras.Designacao FROM Cadeiras, Cursos WHERE Cursos.Designacao == '"+nomeCurso+"' AND Cadeiras.CursoID == Cursos.ID;");
		
		while(rs.next()) {
			list.add(rs.getString("Designacao"));
		}
		link.close();
//		DBAuth.closeConnections();
		return list;
	}
	
	/// FUNCAO QUE RETORNA O ID DE UM CURSO ///
	public static int getCursoID(String nomeCurso) throws SQLException {
		Statement link = DBAuth.establishConnectionToDB();
		ResultSet rs = link.executeQuery("SELECT ID FROM Cursos WHERE Cursos.Designacao == '"+nomeCurso+"';");
		if(!rs.next()){
			link.close();
			return -1;
		}
		int ID = rs.getInt("ID");
		link.close();
//		DBAuth.closeConnections();
		return ID;
	}
	
	/// FUNCAO QUE RETORNA O NOME A PARTIR DO ID DE UM CURSO ///
	public static String getCursoName(int ID) throws SQLException {
		Statement link = DBAuth.establishConnectionToDB();
		ResultSet rs = link.executeQuery("SELECT Designacao FROM Cursos WHERE ID == '"+ID+"';");
		if(ID == -1 || !rs.next()){
			link.close();
			return "Este gajo não anda no ISCTE";
		}
		String name = rs.getString("Designacao");
		link.close();
		return name;
	}
	
	/// FUNCAO QUE RETORNA O ID DE UMA CADEIRA ///
	public static int getCadeiraID(String nomeCadeira) throws SQLException {
		Statement link = DBAuth.establishConnectionToDB();
		ResultSet rs = link.executeQuery("SELECT ID FROM Cadeiras WHERE Cadeiras.Designacao == '"+nomeCadeira+"';");
		System.out.println("NOME CADEIRA: "+nomeCadeira);
		if(!rs.next()){
			link.close();
			return -1;
		}
		int ID = rs.getInt("ID");
		link.close();
//		DBAuth.closeConnections();
		return ID;
	}
	
	/// FUNCAO QUE RETORNA O NOME A PARTIR DO ID DE UMA CADEIRA ///
	public static String getCadeiraName(int ID) throws SQLException {
		Statement link = DBAuth.establishConnectionToDB();
		ResultSet rs = link.executeQuery("SELECT Designacao FROM Cadeiras WHERE Cadeiras.ID == '"+ID+"';");
		System.out.println("ID CADEIRA: "+ID);
		if(ID == -1 || !rs.next()){
			link.close();
			return "Erro";
		}
		String name = rs.getString("Designacao");
		link.close();
		return name;
	}

	/// FUNCAO QUE RETORNA O ID A PARTIR DO EMAIL ///
	public static int getIDFromEmail(String email) throws SQLException {
		Statement link = DBAuth.establishConnectionToDB();
		ResultSet rs = link.executeQuery("SELECT ID FROM Utilizadores WHERE Utilizadores.Email == '"+email+"';");
		int ID = rs.getInt("ID");
		link.close();
		return ID;
	}
	
	/// FUNCAO QUE RETORNA O EMAIL A PARTIR DO ID ///
	public static String getEmailFromID(int ID) throws SQLException {
		Statement link = DBAuth.establishConnectionToDB();
		ResultSet rs = link.executeQuery("SELECT ID FROM Utilizadores WHERE Utilizadores.ID == '"+ID+"';");
		String email = rs.getString("Email");
		link.close();
		return email;
	}
	
	public static int getNumberLikes(int ID) throws SQLException {
		Statement link = DBAuth.establishConnectionToDB();
		ResultSet rs = link.executeQuery("SELECT * FROM Likes WHERE UserID == '"+ID+"';");
		int num = 0;
		while(rs.next()){
			num++;
		}
		link.close();
		return num;
	}
	
	public static int getNumberComments(int ID) throws SQLException {
		Statement link = DBAuth.establishConnectionToDB();
		ResultSet rs = link.executeQuery("SELECT * FROM Comentarios WHERE UserID == '"+ID+"';");
		int num = 0;
		while(rs.next()){
			num++;
		}
		link.close();
		return num;
	}
	
	public static String getUserImage(int ID) throws SQLException {
		Statement link = DBAuth.establishConnectionToDB();
		ResultSet rs = link.executeQuery("SELECT Img FROM Utilizadores WHERE ID == '"+ID+"';");
		if(rs.next()){
			String img = rs.getString("Img");
			link.close();
			return img;
		}
		link.close();
		return "http://placehold.it/250x250";
	}
	
	public static String getUserDesc(int ID) throws SQLException {
		Statement link = DBAuth.establishConnectionToDB();
		ResultSet rs = link.executeQuery("SELECT Desc FROM Utilizadores WHERE ID == '"+ID+"';");
		if(rs.next()){
			String desc = rs.getString("Desc");
			link.close();
			return desc;
		}
		link.close();
		return "No description.";
	}
	
	public static int getUserAno(int ID) throws SQLException {
		Statement link = DBAuth.establishConnectionToDB();
		ResultSet rs = link.executeQuery("SELECT Ano FROM Utilizadores WHERE ID == '"+ID+"';");
		if(rs.next()){
			int ano = rs.getInt("Ano");
			link.close();
			return ano;
		}
		link.close();
		return 1;
	}
	
	public static int getUserCursoID(int ID) throws SQLException {
		Statement link = DBAuth.establishConnectionToDB();
		ResultSet rs = link.executeQuery("SELECT Curso FROM Utilizadores WHERE ID == '"+ID+"';");
		if(rs.next()){
			int curso = rs.getInt("Curso");
			link.close();
			return curso;
		}
		link.close();
		return -1;
	}
	
	public static int getNumberFilesUser(int ID) throws SQLException {
		Statement link = DBAuth.establishConnectionToDB();
		ResultSet rs = link.executeQuery("SELECT * FROM Conteudo WHERE UserID == '"+ID+"';");
		int num = 0;
		while(rs.next()){
			num++;
		}
		link.close();
		return num;
	}
	
	public static ArrayList<ArrayList<String>> getAllUsers() throws SQLException {
		ArrayList<ArrayList<String>> listOut = new ArrayList<ArrayList<String>>();
		Statement dblink = DBAuth.establishConnectionToDB();
		ResultSet rs = dblink.executeQuery("SELECT * FROM Utilizadores;");
		while(rs.next()){
			ArrayList<String> listIn = new ArrayList<String>();
			for(int i = 1; i <= 12; i++){
				listIn.add(rs.getString(i));
			}
			listOut.add(listIn);
		}
		dblink.close();
		return listOut;
	}
	
	public static ArrayList<ArrayList<String>> getAllReported() throws SQLException {
		ArrayList<ArrayList<String>> listOut = new ArrayList<ArrayList<String>>();
		Statement dblink = DBAuth.establishConnectionToDB();
		ResultSet rs = dblink.executeQuery("SELECT * FROM Conteudo WHERE Reports > 0;");
		while(rs.next()){
			ArrayList<String> listIn = new ArrayList<String>();
			for(int i = 1; i <= 13; i++){
				listIn.add(rs.getString(i));
			}
			listOut.add(listIn);
		}
		dblink.close();
		return listOut;
	}
	
	public static ArrayList<ArrayList<String>> getAllMessages() throws SQLException {
		ArrayList<ArrayList<String>> listOut = new ArrayList<ArrayList<String>>();
		Statement dblink = DBAuth.establishConnectionToDB();
		ResultSet rs = dblink.executeQuery("SELECT * FROM Mensagens;");
		while(rs.next()){
			ArrayList<String> listIn = new ArrayList<String>();
			for(int i = 1; i <= 6; i++){
				listIn.add(rs.getString(i));
			}
			listOut.add(listIn);
		}
		dblink.close();
		return listOut;
	}
	
	public static ArrayList<String> getMessage(int mid) throws SQLException {
		ArrayList<String> listIn = new ArrayList<String>();
		Statement dblink = DBAuth.establishConnectionToDB();
		ResultSet rs = dblink.executeQuery("SELECT * FROM Mensagens WHERE ID == '"+mid+"'");
		if(rs.next()){
			for(int i = 1; i <= 6; i++){
				listIn.add(rs.getString(i));
			}
		}
		return listIn;
	}
	
	public static boolean userIsPending(int ID) throws SQLException {
		Statement link = DBAuth.establishConnectionToDB();
		ResultSet rs = link.executeQuery("SELECT Status FROM Utilizadores WHERE ID == '"+ID+"';");
		if(rs.next()){
			boolean pending = rs.getString("Status").equals("pending");
			link.close();
			return pending;
		}
		link.close();
		return false;
	}
}
