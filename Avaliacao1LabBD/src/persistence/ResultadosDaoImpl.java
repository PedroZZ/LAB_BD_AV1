package persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connection.ConnectionImpl;
import connection.GenericConnection;
import entity.Resultados;

public class ResultadosDaoImpl implements ResultadosDao {

	private Connection c;
	
	public ResultadosDaoImpl() {
		GenericConnection gc = new ConnectionImpl();
		c = gc.getConnection();
	}
	
	
	@Override
	public List<Resultados> resultadosGrupos(String grupo) {
		List<Resultados> lista = new ArrayList<>(); 
		String query = "select dbo.grupo(?)";
		PreparedStatement ps;
		try {
			ps = c.prepareStatement( query );
			ps.setString(1, grupo );
			ResultSet rs = ps.executeQuery();
			
			
			while( rs.next() ) {
			Resultados r = new Resultados();

			r.setNome_time(rs.getString("nome_time"));
			r.setNum_jogos_disputados(rs.getInt("num_jogos_disputados"));
			r.setVitorias(rs.getInt("vitorias"));
			r.setVitorias(rs.getInt("empates"));
			r.setVitorias(rs.getInt("derrotas"));
			r.setVitorias(rs.getInt("gols_marcados"));
			r.setVitorias(rs.getInt("gols_sofridos"));
			r.setVitorias(rs.getInt("saldo_gols"));
			r.setVitorias(rs.getInt("pontos"));
			lista.add(r);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		// TODO Auto-generated method stub
		return lista;
	}

	@Override
	public List<Resultados> resultadosGeral(String grupo) {
		List<Resultados> lista = new ArrayList<>(); 
		String query = "";
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Resultados> quartasDeFinal(String grupo) {
		List<Resultados> lista = new ArrayList<>(); 
		String query = "";
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Resultados> rebaixados(String grupo) {
		List<Resultados> lista = new ArrayList<>(); 
		String query = "";
		// TODO Auto-generated method stub
		return null;
	}

}
