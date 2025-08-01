package modelo.produto;

import java.math.BigDecimal;

import modelo.categoria.Categoria;

public class Produto {
	private int id;
	private String descricao;
	private BigDecimal preco;
	private byte[] fotoBytes;
	private int quantidade;
	private Categoria categoria;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDescricao() {
		return descricao;
	}
	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}
	public BigDecimal getPreco() {
		return preco;
	}
	public void setPreco(BigDecimal preco) {
		this.preco = preco;
	}
	public byte[] getFotoBytes() { return fotoBytes; }
	public void setFotoBytes(byte[] fotoBytes) { this.fotoBytes = fotoBytes; }
	public int getQuantidade() {
		return quantidade;
	}
	public void setQuantidade(int quantidade) {
		this.quantidade = quantidade;
	}
	public Categoria getCategoria() {
		return categoria;
	}
	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
	}

}
