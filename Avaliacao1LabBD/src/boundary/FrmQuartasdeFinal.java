package boundary;

import java.awt.Color;
import java.awt.Font;
import java.awt.SystemColor;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.border.LineBorder;

import control.CtrlResultados;
import entity.QuartasdeFinal;
import util.ModeloTabela;
import javax.swing.JLabel;
import javax.swing.ImageIcon;

/**
 * Classe Respons�vel pela exibi��o do formulario das quartas de final
 * @author hury
 *
 */

public class FrmQuartasdeFinal {

	private JPanel panPrincipal;
	private JFrame janela;
	private ModeloTabela modeloA;
	private ModeloTabela modeloB;
	private ModeloTabela modeloC;
	private ModeloTabela modeloD;
	private JTable tblA;
	private JTable tblB;
	private JTable tblC;
	private JTable tblD;
	private JLabel lblQuartasdeFinal;
	
	public FrmQuartasdeFinal(){
		janela = new JFrame("Quartas de Final");
		
		panPrincipal = new JPanel();
		panPrincipal.setBackground(SystemColor.text);
		panPrincipal.setForeground(Color.WHITE);
		panPrincipal.setLayout(null);

		
		lblQuartasdeFinal = new JLabel("Proje\u00E7\u00E3o das quartas de final");
		lblQuartasdeFinal.setForeground(SystemColor.controlHighlight);
		lblQuartasdeFinal.setFont(new Font("Verdana", Font.BOLD, 18));
		lblQuartasdeFinal.setBounds(219, 11, 308, 36);
		panPrincipal.add(lblQuartasdeFinal);
		

		JButton btnVoltar = new JButton("Voltar");
		btnVoltar.setBounds(605, 377, 89, 23);
		panPrincipal.add(btnVoltar);

		
		janela.setContentPane(panPrincipal);
		
		JScrollPane scrollPaneA = new JScrollPane();
		scrollPaneA.setBounds(65, 137, 275, 41);
		panPrincipal.add(scrollPaneA);
		
		tblA = new JTable();
		scrollPaneA.setViewportView(tblA);
		
		JScrollPane scrollPaneB = new JScrollPane();
		scrollPaneB.setBounds(406, 137, 275, 41);
		panPrincipal.add(scrollPaneB);
		
		tblB = new JTable();
		scrollPaneB.setViewportView(tblB);
		
		JScrollPane scrollPaneC = new JScrollPane();
		scrollPaneC.setBounds(67, 266, 275, 41);
		panPrincipal.add(scrollPaneC);
		
		tblC = new JTable();
		scrollPaneC.setViewportView(tblC);
		
		JScrollPane scrollPaneD = new JScrollPane();
		scrollPaneD.setBounds(408, 266, 275, 41);
		panPrincipal.add(scrollPaneD);
		
		tblD = new JTable();
		scrollPaneD.setViewportView(tblD);
		
		tblA.setFont(new Font("Tahoma", Font.PLAIN, 15));
		tblA.setBorder(new LineBorder(Color.BLACK));
		tblA.setGridColor(Color.BLACK);
		tblA.setShowGrid(true);
		
		tblB.setFont(new Font("Tahoma", Font.PLAIN, 15));
		tblB.setBorder(new LineBorder(Color.BLACK));
		tblB.setGridColor(Color.BLACK);
		tblB.setShowGrid(true);
		
		tblC.setFont(new Font("Tahoma", Font.PLAIN, 15));
		tblC.setBorder(new LineBorder(Color.BLACK));
		tblC.setGridColor(Color.BLACK);
		tblC.setShowGrid(true);
		
		tblD.setFont(new Font("Tahoma", Font.PLAIN, 15));
		tblD.setBorder(new LineBorder(Color.BLACK));
		tblD.setGridColor(Color.BLACK);
		tblD.setShowGrid(true);
		
		JLabel lblNewLabel = new JLabel("Grupo A");
		lblNewLabel.setBackground(Color.BLACK);
		lblNewLabel.setForeground(new Color(153, 204, 204));
		lblNewLabel.setFont(new Font("Verdana", Font.BOLD, 14));
		lblNewLabel.setBounds(155, 106, 76, 20);
		panPrincipal.add(lblNewLabel);
		
		JLabel lblNewLabel_1 = new JLabel("Grupo C");
		lblNewLabel_1.setBackground(Color.BLACK);
		lblNewLabel_1.setForeground(new Color(153, 204, 204));
		lblNewLabel_1.setFont(new Font("Verdana", Font.BOLD, 14));
		lblNewLabel_1.setBounds(155, 241, 76, 20);
		panPrincipal.add(lblNewLabel_1);
		
		JLabel lblNewLabel_2 = new JLabel("Grupo D");
		lblNewLabel_2.setBackground(Color.BLACK);
		lblNewLabel_2.setForeground(new Color(153, 204, 204));
		lblNewLabel_2.setFont(new Font("Verdana", Font.BOLD, 14));
		lblNewLabel_2.setBounds(499, 241, 76, 20);
		panPrincipal.add(lblNewLabel_2);
		
		JLabel lblNewLabel_3 = new JLabel("Grupo B");
		lblNewLabel_3.setBackground(Color.BLACK);
		lblNewLabel_3.setForeground(new Color(153, 204, 204));
		lblNewLabel_3.setFont(new Font("Verdana", Font.BOLD, 14));
		lblNewLabel_3.setBounds(499, 106, 76, 20);
		panPrincipal.add(lblNewLabel_3);
		
		CtrlResultados ctrl = new CtrlResultados();
		List<QuartasdeFinal> listaquarta = new ArrayList<QuartasdeFinal>();
		
		listaquarta = ctrl.quartasdeFinal("A");
		modeloA = new ModeloTabela(listaquarta);
		tblA.getTableHeader().setReorderingAllowed(false);
		tblA.setModel(modeloA);
		
		listaquarta = ctrl.quartasdeFinal("B");
		modeloB = new ModeloTabela(listaquarta);
		tblB.getTableHeader().setReorderingAllowed(false);
		tblB.setModel(modeloB);
		
		listaquarta = ctrl.quartasdeFinal("C");
		modeloC = new ModeloTabela(listaquarta);
		tblC.getTableHeader().setReorderingAllowed(false);
		tblC.setModel(modeloC);
		
		listaquarta = ctrl.quartasdeFinal("D");
		modeloD = new ModeloTabela(listaquarta);
		tblD.getTableHeader().setReorderingAllowed(false);
		tblD.setModel(modeloD);
		
		JLabel lblNewLabel_4 = new JLabel("");
		lblNewLabel_4.setIcon(new ImageIcon(FrmQuartasdeFinal.class.getResource("/img/Fotolia_66427946_Stadium-lights.jpg")));
		lblNewLabel_4.setBounds(-489, -105, 1245, 542);
		panPrincipal.add(lblNewLabel_4);
		
		janela.setSize(752,453);
		janela.setLocationRelativeTo(null);
        janela.setResizable(false);
		janela.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		janela.setVisible(true);

		
		btnVoltar.addActionListener(l -> {
			janela.dispose();
			janela = null;
			new FrmPrincipal();
		});
		
		
	}
}
