package modelo.venda;

import java.time.LocalDateTime;

import modelo.usuario.Usuario;

public class Venda {
	private int id;
	private LocalDateTime data_hora;
	private Usuario usuario;

	public Usuario getUsuario() {
		return usuario;
	}
	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}
	public LocalDateTime getData_hora() {
		return data_hora;
	}
	public void setData_hora(LocalDateTime data_hora) {
		this.data_hora = data_hora;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
}
