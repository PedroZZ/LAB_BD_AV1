package boundary;

import java.awt.Color;
import java.awt.Font;

import javax.swing.ImageIcon;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.border.LineBorder;
import javax.swing.JLabel;
import javax.swing.JTextField;

import util.TratamentoTextFields;

import javax.swing.JButton;

public class FrmPesquisaRodada {
	
	private JFrame janela;
	private JPanel panPrincipal;
	private JTable tabela;
	private JScrollPane scrollPane;
	private JTextField txtDataRodada;
	private JLabel lblRodadasDoDia;
	private JLabel lblDigiteAData;
	private JButton btnPesquisar;
	private JMenuBar menuBarra;
	private JMenu menu;
	private JMenuItem menuPrincipal;
	
	public FrmPesquisaRodada() {
		janela = new JFrame("Pesquisa Rodadas");
		panPrincipal = new JPanel();
		panPrincipal.setBackground(Color.WHITE);
		
		menuBarra = new JMenuBar();
		janela.setJMenuBar(menuBarra);
		
		menu = new JMenu("Menu");
		menuBarra.add(menu);
		
		menuPrincipal = new JMenuItem("Menu Principal");
		menuPrincipal.setIcon(new ImageIcon(getClass()
				.getResource("/img/HomeMenu.png")));
		menu.add(menuPrincipal);
		
		tabela = new JTable();
		tabela.setFont(new Font("Tahoma", Font.PLAIN, 15));
		tabela.setBorder(new LineBorder(Color.BLACK));
		tabela.setGridColor(Color.BLACK);
		tabela.setShowGrid(true);
		
		scrollPane = new JScrollPane();
		scrollPane.getViewport().setBorder(null);
		
		txtDataRodada = new JTextField();
		txtDataRodada = TratamentoTextFields.mascara(txtDataRodada, "data");
		txtDataRodada.setFont(new Font("Tahoma", Font.PLAIN, 18));
		txtDataRodada.setToolTipText("Digite a data");
		txtDataRodada.setBounds(198, 27, 109, 24);
		panPrincipal.add(txtDataRodada);
		txtDataRodada.setColumns(10);
		scrollPane.setViewportView(tabela);
		scrollPane.setBounds(116, 142, 525, 314);
		panPrincipal.add(scrollPane);
		
		janela.setSize(749,525);
		janela.setContentPane( panPrincipal );
		panPrincipal.setLayout(null);
		
		lblRodadasDoDia = new JLabel("Rodadas do Dia: \"  \"");
		lblRodadasDoDia.setFont(new Font("Tahoma", Font.BOLD, 26));
		lblRodadasDoDia.setBounds(116, 90, 290, 24);
		panPrincipal.add(lblRodadasDoDia);
		
		lblDigiteAData = new JLabel("Digite a Data: ");
		lblDigiteAData.setFont(new Font("Tahoma", Font.PLAIN, 14));
		lblDigiteAData.setBounds(101, 26, 109, 29);
		panPrincipal.add(lblDigiteAData);
		
		btnPesquisar = new JButton("");
		btnPesquisar.setBounds(323, 14, 83, 41);
		panPrincipal.add(btnPesquisar);
		btnPesquisar.setIcon(new ImageIcon(this.getClass().getResource
				("/img/Lupa.png")));
		
		menuPrincipal.addActionListener(l -> {
			janela.dispose();
			janela = null;
			new FrmPrincipal();
		});
		
		janela.setLocationRelativeTo(null);
        janela.setResizable(false);
		janela.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		janela.setVisible(true);
	}
}
