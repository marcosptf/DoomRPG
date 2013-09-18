/*******************************************************************************
 * @author:marcosptf <marcosptf@yahoo.com.br>
 * @since:25/02/2013
 * @desc:classe de validação de todos os dados necessarios para form;
 *******************************************************************************/


function validacao(){

//se precisar de propriedades de classe
//     this.dados = pDados;

    //declaracao de metodo
    this.isVazio = function(pDados){
    	return(((pDados=="") || (pDados.length<1)) ? (true) : (false));
    }

    //saida no console
    this.getLog = function(pDados){
        if(!this.isVazio(pDados)){
            console.log(pDados);
        }
    }

    //retorna true se na expressao somente existem numeros
    this.isNumeric = function(pDados){
        if(!isNaN(pDados)){
            return true;
        }else{
            return false;
        }
    }


    //retorna true se na expressao somente existem numeros
    this.isText = function(pDados){
        if(isNaN(pDados)){
            return true;
        }else{
            return false;
        }
    }



}

