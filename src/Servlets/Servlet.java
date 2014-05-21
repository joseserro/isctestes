package Servlets;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Site.DBInfo;
import Site.DBUtil;

/**
 * Servlet implementation class Servlet
 */
@WebServlet("/servlet")
public class Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public static final String DB_PATH = "/usr/share/apache-tomcat-7.0.37/webapps/ROOT/database/Bb.db";
							/* DB_PATH = "workspace/TrabalhoPR/WebContent/database/Bb.db"; */
	
	private HttpSession session;
	private String sessao, origem, url, button, cad, cursoEscolhido;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Servlet() {
		super();
	}

	/**
	 * @throws SQLException 
	 * @throws NoSuchAlgorithmException 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, NoSuchAlgorithmException, SQLException {
		response.setContentType("text/html; charset=ISO-8859-1");
		session = request.getSession(true);
		sessao = request.getParameter("sessao");
		
		if( request.getParameter("focus") != null){
			session.setAttribute("origem",(String) request.getParameter("focus"));
		}
		
		origem = (String) session.getAttribute("origem");
		cursoEscolhido = request.getParameter("cursos");
		button = request.getParameter("button");
		//cad = request.getParameter("cadeira");
		cad = (String) session.getAttribute("cadeira");
		//System.out.println("cadeira ID = "+cad);
		if(sessao == null)
			sessao = "";
		if(cursoEscolhido == null)
			cursoEscolhido = "";
		if(origem == null)
			origem = "";
		if(button == null)
			button = "";
		if(cad == null || cad.equals("Erro")){
			cad = request.getParameter("cadeira");
			if(cad == null){
				cad = "";
			}
		}
		
		//System.out.println("Cadeira... "+cad);
		
		String primeiroNome = request.getParameter("firstName");
		String ultimoNome = request.getParameter("lastName");
		String email = request.getParameter("email");
		String password = request.getParameter("typePassword");
		String curso = request.getParameter("curso");
		
		//System.out.println("sessão = "+sessao);
		//System.out.println(primeiroNome+" "+ultimoNome+" "+email+" "+password+" "+curso);
		
		switch(sessao) {
		case "login":
			if(checkLoginInfo(email, password)) {
				String fullName = DBInfo.getUserNameFromEmail(email);
				int userID = DBInfo.getIDFromEmail(email);
				if(DBInfo.userIsPending(userID)){
					session.setAttribute("userType", "guest");
				} else {
					if(DBUtil.isAdmin(userID)){
						session.setAttribute("userType", "admin");
					} else {
						session.setAttribute("userType", "registered");
					}
				}
				session.setAttribute("fullName", fullName);
				session.setAttribute("userID", ""+userID);
				session.setAttribute("guestAttempt", "false");
				response.sendRedirect("index.jsp");
				return;
			} else {
				session.setAttribute("userType", "guest");
				response.sendRedirect("/content/login/loginFailed.jsp");
				return;
			}
			
		case "logout":
			session.setAttribute("userType", "guest");
			response.sendRedirect("/index.jsp");
			session.invalidate();
			return;

		case "signup":
			System.out.println("registo..");
			int ano = Integer.parseInt(request.getParameter("anoCurso"));
			int cursoID = DBInfo.getCursoID(curso);
			System.out.println("Curso: "+curso+" ID: "+cursoID);
			int errorCode = checkRegisterInfo(primeiroNome, ultimoNome, email, password, cursoID, ano);
			if(errorCode > 0) {
				session.setAttribute("userType", "guest");
				response.sendRedirect("/content/signup/signupFailed.jsp?r="+errorCode);
				//getServletConfig().getServletContext().getRequestDispatcher("/content/signup/signupFailed.jsp").forward(request, response);
				return;
			} else {
				String confirmUrl = "http://zpankr.net/";
				String tipo = "user";
				String status = "pending";
				createNewUser(primeiroNome, ultimoNome, email, password, cursoID, ano, tipo, status);
				session.setAttribute("userType", "guest");
				DBUtil.sendMail("registo@zpankr",
						email,
						"Confirma o teu registo no ISCTEstes",
						"Boas\n\n" +
						"Obrigado pelo teu registo no ISCTestes.\n" +
						"Estás a um passo de poderes tomar proveito de todos os recursos existentes no nosso site.\n" +
						"<a href=\""+confirmUrl+"content/signup/signupConfirm.jsp?confirm="+DBUtil.SHA256(email)+"\">Clica aqui para completares o registo.</a>\n\n" +
						"Saudações Académicas,\n" +
						"ISCTEstes",
						null);
				//getServletConfig().getServletContext().getRequestDispatcher("/content/signup/signupSuccess.jsp").forward(request, response);
				response.sendRedirect("/content/signup/signupSuccess.jsp");
				return;
			}
		}
				
		switch(origem) {
		case "cursos":
			response.sendRedirect("/cadeiras.jsp?cursoid="+DBInfo.getCursoID(cursoEscolhido));
			//getServletConfig().getServletContext().getRequestDispatcher("/cadeiras.jsp").forward(request, response);
			break;
			
		case "conteudo":
			url = request.getParameter("link");
			String likeid = request.getParameter("idcont");
			String reportId = request.getParameter("idrep");
			String iddec = request.getParameter("iddec");
			String comment = request.getParameter("comment");
			String deleteContent = request.getParameter("deleteContent");
			String cidel = request.getParameter("cidel");
			int userId = Integer.parseInt((String) session.getAttribute("userID"));
			
			if(url != null) {
				int id = Integer.parseInt(likeid);
				response.sendRedirect(url);
				DBUtil.updateHits(id);
				break;
			} else if(likeid != null) {
				int id = Integer.parseInt(likeid);
				System.out.println("Updating likes for "+id);
				DBUtil.addLikes(id, userId);
				break;
			} else if(iddec != null) {
				int id = Integer.parseInt(iddec);
				System.out.println("Updating likes for "+id);
				DBUtil.remLikes(id, userId);
				break;
			} else if(reportId != null) {
				int id = Integer.parseInt(reportId);
				DBUtil.updateReports(id, userId);
				break;
			} else if(comment != null){
				int conteudoId = Integer.parseInt(request.getParameter("cid"));
				DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy - HH:mm:ss");
				Date date = new Date();
				String data = dateFormat.format(date);
				DBUtil.newComment(userId, comment, data, conteudoId);
				response.sendRedirect("conteudo.jsp?cid="+conteudoId);
				break;
			} else if(deleteContent != null){
				if(session.getAttribute("userType").equals("admin")){
					int dic = Integer.parseInt(deleteContent);
					ArrayList<String> cont = DBUtil.getContent(dic);
					DBUtil.deleteContent(dic);
					response.sendRedirect("/conteudo.jsp?cadeira="+cont.get(1)+"&tipo="+cont.get(6)+"&ano="+cont.get(5));
				} else {
					response.sendRedirect("/index.jsp"); //not an admin.
				}
				break;
			} else if(cidel != null){
				if(session.getAttribute("userType").equals("admin")){
					DBUtil.deleteComment(Integer.parseInt(cidel));
				}
				break;
			} else {
				break;
			}
			
		case "enviar":
			String cadeira = request.getParameter("selectcadeira");
			String link = request.getParameter("link");
			String titulo = request.getParameter("title");
			String descricao = request.getParameter("descricao");
			String anoStr = request.getParameter("selectano");
			if(anoStr == null)
				anoStr = "0";
			int ano = Integer.parseInt(anoStr);
			String tipo = request.getParameter("radiotipo");
			String epoca = request.getParameter("radioepoca");
			String resolucao = request.getParameter("res");
			
			createNewContent(cadeira, link, titulo, descricao, ano, tipo, epoca, resolucao);
			response.sendRedirect("/content/upload/uploadSuccess.jsp");
			break;
			
		case "perfil":
			String deleteUser = request.getParameter("delUser");
			if(!deleteUser.equals(null)){
				DBUtil.deleteUser(Integer.parseInt(deleteUser));
			}
			response.sendRedirect("/admin.jsp");
			break;
			
		
		case "editprofile":
			String imglink = request.getParameter("imglink");
			String desc = request.getParameter("desc");
			int selectano = Integer.parseInt(request.getParameter("selectano"));
			String selectcurso = request.getParameter("selectcurso");
			int cursoID = DBInfo.getCursoID(selectcurso);
			String passactual = request.getParameter("passactual");
			String passnova = request.getParameter("passnova");
			DBUtil.updateProfile(passactual,passnova,Integer.parseInt((String)session.getAttribute("userID")),imglink, cursoID, selectano, desc);
			response.sendRedirect("profile.jsp");
			break;
		
		case "contactos":
			String contactNome = request.getParameter("nome");
			String contactEmail = request.getParameter("mail");
			String contactMessage = request.getParameter("mensagem");
			DBUtil.storeMessage(contactNome, contactEmail, contactMessage);
			response.sendRedirect("content/contact/contactSuccess.jsp");
			break;
		
		case "admin":
			String deleteMessage = request.getParameter("deleteMessage");
			if(!deleteMessage.equals(null)){
				DBUtil.deleteMessage(Integer.parseInt(deleteMessage));
			}
			response.sendRedirect("/admin.jsp");
			break;
			
		}
	}
	
	private int checkRegisterInfo(String primeiroNome, String ultimoNome, String email, String password, int cursoID, int ano) throws SQLException{
		if(DBUtil.emailExistsOnDB(email)){
			return 1;
		} else if(primeiroNome.equals("") || ultimoNome.equals("")){
			return 2;
		} else if(password.length() < 6){
			return 3;
		} else if(!DBUtil.cursoExists(cursoID)){
			return 4;
		} else if(ano < 1 || ano > 5) {
			return 5;
		} else if(!MailPertenceAoIscte(email)){
			return 6;
		}
		return 0;
	}
	
	private boolean MailPertenceAoIscte(String email){
		return email.endsWith("@iscte-iul.pt");
	}

	private boolean checkLoginInfo(String email, String password) throws NoSuchAlgorithmException, SQLException {
		password = DBUtil.SHA256(password);
		boolean userExists = DBUtil.userExistsOnDB(email, password);
		if(email != null && password != null) {
			if(userExists)
				return true;
		} return false;
	}

	private void createNewUser(String primeiroNome, String ultimoNome, String email, 
			String password, int cursoID, int ano, String tipo, String status) {
		DBUtil.saveSignupInfo(primeiroNome, ultimoNome, email, password, cursoID, ano, tipo, status);
	}
	
	private void createNewContent(String cadeira, String link, String titulo, String descricao,
			int ano, String tipo, String epoca, String resolucao) throws NumberFormatException, SQLException {
		
		
		if(link == null || cadeira == null || titulo == null || descricao == null){
			return;
		}
		int resb = 1;
		if(resolucao == null)
			resb = 0;
		
		if(epoca == null)
			epoca = "0";
		int userID =  Integer.parseInt((String) session.getAttribute("userID"));
		
		DBUtil.saveContentInfo(cadeira, link, titulo, descricao, ano, Integer.parseInt(tipo), Integer.parseInt(epoca), resb, userID);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			processRequest(request, response);
		} catch (NoSuchAlgorithmException | SQLException e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			processRequest(request, response);
		} catch (NoSuchAlgorithmException | SQLException e) {
			e.printStackTrace();
		}
	}
}
