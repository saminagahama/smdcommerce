package modelo.venda;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import modelo.usuario.Usuario;
import modelo.venda_produto.VendaProduto;

public class Venda {
	private int id;
	private LocalDateTime data_hora;
	private Usuario usuario;
	private BigDecimal valor_total;

	private List<VendaProduto> itens;

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
	public BigDecimal getValor_total() {
		return valor_total;
	}
	public void setValor_total(BigDecimal valor_total) {
		this.valor_total = valor_total;
	}
	public List<VendaProduto> getItens() {
		return itens;
	}
	public void setItens(List<VendaProduto> itens) {
		this.itens = itens;
	}
}
