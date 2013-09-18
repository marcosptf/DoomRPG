/*******************************************************************************
 * @author:marcosptf <marcosptf@yahoo.com.br>
 * @since:25/02/2013
 * @desc:programação js do jogo DoomRPG.
 * aqui eh instanciado a classe de validação, a classe do game e ultilizado o jquery
 * para realizar a manipulação de dados.
 *******************************************************************************/

valid = new validacao();
doom  = new doomRpg();


$("#entraGame").click = function(){

    if((!valid.isVazio($("#login").val())) && (!valid.isVazio($("#senha").val()))){
        //realiza o post para a servlet tratar os dados e retornar as respectivas informações para logar o usuario
    }else{
        
    }

}