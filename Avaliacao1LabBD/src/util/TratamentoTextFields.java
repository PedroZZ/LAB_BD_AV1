package util;

import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.text.ParseException;

import javax.swing.JFormattedTextField;
import javax.swing.JTextField;
import javax.swing.text.MaskFormatter;

/**
 * Classe para tratamento dos campos
 * @author Pedro Zuzi
 *
 */
public final class TratamentoTextFields extends JTextField{
	private static final long serialVersionUID = 4693065480438008645L;
	
	private int tamanhoMaximo;
	
	/**
	 * Construtor
	 * chama o m�todo para aceitar apenas letras
	 */
	public TratamentoTextFields() {
		addKeyListener(new KeyAdapter() {
			@Override
		    public void keyTyped(KeyEvent evt) {
		        apenasLetras(evt);
		    }
		});
	}
	
	/**
	 * Construtor
	 * chama o m�todo para aceitar apenas n�meros
	 * @param maximo de caracteres aceitos 
	 */
	public TratamentoTextFields(int maximo) {
	    setTamanhoCaracteres(maximo);
	    
	    addKeyListener(new KeyAdapter() {
	    	 @Override
	    	    public void keyTyped(KeyEvent evt) {
	    	        apenasNumeros(evt);
	    	     }
	    });
	}
	
	/**
	 * Construtor
	 * chama o m�todo para tratamento do campo de usu�rio
	 * @param campo para o tratamento
	 */
	public TratamentoTextFields(JTextField campo) {
		addKeyListener(new KeyAdapter() {
			@Override
		    public void keyTyped(KeyEvent evt) {
		        usuario(evt);
		    }
		});
	}
	
	/**
	 * Construtor
	 * Chama o m�todo para tratamento do campo sal�rio
	 * @param campo a ser tratado
	 * @param maximo de caracteres aceitos
	 */
	public TratamentoTextFields(JTextField campo, int maximo) {
		setTamanhoCaracteres(maximo);
		
	    addKeyListener(new KeyAdapter() {
	    	 @Override
	    	    public void keyTyped(KeyEvent evt) {
	    	        salario(evt);
	    	     }
	    });
	}
	
	/**
	 * M�todo para aceitar apenas letras
	 * @param e evento do teclado
	 */
	private void apenasLetras(KeyEvent e) {
		String caracteres = "1234567890'!@#$%�&*()_+/\\;.[{}]����*-+,=<>?|\"";
		
		if (caracteres.contains(e.getKeyChar() + "")) {
			e.consume();
		}
	}
	
	/**
	 * M�todo para aceitar apenas n�meros
	 * @param e evento do teclado
	 */
	private void apenasNumeros(KeyEvent e) {
		String caracteres = "0987654321";
		if (!caracteres.contains(e.getKeyChar() + "")) {
			e.consume();
		}
		if ((getText().length() >= getTamanhoMaximo())
				&& (getTamanhoMaximo() != -1)) {
			e.consume();
			setText(getText().substring(0, getTamanhoMaximo()));
		}
	}
	
	/**
	 * M�todo para definir a m�scara do campo
	 * @param campo ser tratado
	 * @param mascara, o tipo de mascara
	 * @return campo
	 */
	public static JTextField mascara(JTextField campo, String mascara) {
		if (mascara.equalsIgnoreCase("cpf")) {
			try {
				MaskFormatter maskCpf = new MaskFormatter("###.###.###-##");
				campo = new JFormattedTextField(maskCpf);
				return campo;
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}else if (mascara.equalsIgnoreCase("data")) {
			try {
				MaskFormatter maskCpf = new MaskFormatter("##/##/####");
				campo = new JFormattedTextField(maskCpf);
				return campo;
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		return campo;
	}
	
	/**
	 * M�todo para tratamento do campo sal�rio
	 * @param e evento do teclado
	 */
	private void salario( KeyEvent e ) {
		String caracteres = "0987654321.,";
		if (getText().contains(".") || getText().contains(",")) {
			caracteres = "0987654321";
		}
		if (!caracteres.contains(e.getKeyChar() + "")) {
			e.consume();
		}
		if ((getText().length() >= getTamanhoMaximo())
				&& (getTamanhoMaximo() != -1)) {
			e.consume();
			setText(getText().substring(0, getTamanhoMaximo()));
		}
	}

	/**
	 * M�todo para retorno do tamanho m�ximo de
	 * caracteres estabelecido
	 * @return tamanho
	 */
	public int getTamanhoMaximo() {
		return tamanhoMaximo;
	}

	/**
	 * M�todo para setar o tamanho m�ximo de caracteres
	 * @param tamanhoCaracteres
	 */
	public void setTamanhoCaracteres(int tamanhoCaracteres) {
		this.tamanhoMaximo = tamanhoCaracteres;
	}

	/**
	 * M�todo para tratamento do campo usu�rio
	 * @param e evento do teclado
	 */
	private void usuario(KeyEvent e) {
		String caracteres = " '!@#$%�&*()+/\\;.[{}]����*�`^~+,=<>?|\"";
		
		if (caracteres.contains(e.getKeyChar() + "")) {
			e.consume();
		}
	}
	
}

