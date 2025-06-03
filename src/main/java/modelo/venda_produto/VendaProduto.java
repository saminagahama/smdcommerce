package modelo.venda_produto;

import java.math.BigDecimal;

import modelo.produto.Produto;
import modelo.venda.Venda;

public class VendaProduto {
	private Venda venda;
	private Produto produto;
	private int quantidade;
	private BigDecimal preco;

	public Venda getVenda() {
		return venda;
	}
	public void setVenda(Venda venda) {
		this.venda = venda;
	}
	public int getQuantidade() {
		return quantidade;
	}
	public void setQuantidade(int quantidade) {
		this.quantidade = quantidade;
	}
	public Produto getProduto() {
		return produto;
	}
	public void setProduto(Produto produto) {
		this.produto = produto;
	}
	public BigDecimal getPreco() {
		return preco;
	}
	public void setPreco(BigDecimal preco) {
		this.preco = preco;
	}
}
