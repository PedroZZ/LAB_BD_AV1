package entity;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Annota��o das colunas da Tabela
 * @author Pedro Zuzi
 *
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)

public @interface Coluna {

	/**
	 * M�todo para definir a posi��o da coluna na tabela
	 * @return N�mero da coluna
	 */
	int posicao();

	/**
	 * M�todo para definir o nome da coluna na tabela
	 * @return Nome da coluna
	 */
	String nome();

}
