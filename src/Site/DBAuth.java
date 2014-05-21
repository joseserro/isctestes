package Site;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import Servlets.Servlet;

public class DBAuth {

	private static Connection ligacao;
	private static Statement comando;

	/// ESTABELECE A CONEXÃO COM A BASE DE DADOS ///
	public static Statement establishConnectionToDB() {
		if(comando == null){
			try {
				Class.forName("org.sqlite.JDBC");
				ligacao = DriverManager.getConnection("jdbc:sqlite:"+Servlet.DB_PATH); 
				//ligacao.setReadOnly(false);
				comando = ligacao.createStatement();
			}
			catch(SQLException | ClassNotFoundException e) {
				e.printStackTrace();
			}
		}
		return comando;
	}
	
	/// cenas.. ///
	public static Connection getConnection(){
		return ligacao;
	}
	
	/// FECHA AS CONEXÕES ///
//	public static void closeConnections() throws SQLException {
//		//ligacao.close();
//	}
	
	
}