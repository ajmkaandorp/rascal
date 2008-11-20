package org.meta_environment.rascal.ast; 
import org.eclipse.imp.pdb.facts.ITree; 
public abstract class ModuleName extends AbstractAST { 
  static public class Lexical extends ModuleName {
	private String string;
	/*package*/ Lexical(ITree tree, String string) {
		this.tree = tree;
		this.string = string;
	}
	public String getString() {
		return string;
	}

 	@Override
	public <T> T accept(IASTVisitor<T> v) {
     		return v.visitModuleNameLexical(this);
  	}
} static public class Ambiguity extends ModuleName {
  private final java.util.List<org.meta_environment.rascal.ast.ModuleName> alternatives;
  public Ambiguity(java.util.List<org.meta_environment.rascal.ast.ModuleName> alternatives) {
	this.alternatives = java.util.Collections.unmodifiableList(alternatives);
  }
  public java.util.List<org.meta_environment.rascal.ast.ModuleName> getAlternatives() {
	return alternatives;
  }
  
  @Override
public <T> T accept(IASTVisitor<T> v) {
     return v.visitModuleNameAmbiguity(this);
  }
} @Override
public abstract <T> T accept(IASTVisitor<T> visitor);
}