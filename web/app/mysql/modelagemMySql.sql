/*************************************************
jogo on-line em JSP => Doom rpg on line
@marcosptf

não vamos criar, vamos fazer em browser o jogo Doom 1 que eh em fps, com as mesmas
telas/personagens/enredo/roteiro;

tecnologias:
jsp
tomcat
mysql

serão 4 tipos de tabelas

=>param:
tabelas destinadas a armazenar os parametros para uma certa finalidade do jogo

=>temp:
tabelas temporárias

=>log:
tabelas relacionadas somente ao sistema de log

=>dados:
tabelas relacionadas somente para armazenar informações relevantes do jogo


**************************************************/

/*MySqlMySqlMySqlMySqlMySqlMySqlMySqlMySqlMySqlMySqlMySqlMySqlMySqlMySqlMySqlMySql*/

/*************************************************
*Criação do Banco de Dados MySql DoomRpg OnLine
**************************************************/
--create database doomrpg;
use doomrpg;



/*************************************************
*Tabela Jogador
*Esta tabela serve para armazenar os dados de acesso
*do jogador no Doom RPG
*o nickname sera ultilizado dentro do jogo
*o email sera seu login para acesso
**************************************************/
create table dados_jogador(
dados_jogador_id              double precision not null primary key auto_increment,
dados_jogador_nickname        character varying(150) not null,
dados_jogador_email           character varying(255) not null,
dados_jogador_senha           character varying(32)  not null,
dados_jogador_data            timestamp not null default now()
);
select * from dados_jogador;





/*************************************************
*tabela de parametros com os eventos pré definidos para logo do jogo para ser
usado na tabela de logs
**************************************************/
create table param_eventosjogo(
param_eventosjogo_id              integer not null primary key auto_increment,
param_eventosjogo_descricao       character varying(255) not null
);
insert into param_eventosjogo(param_eventosjogo_descricao)values('logon no jogo'),('troca de senha'),
('novo jogo'),('salvou o jogo'),('outras operações');
select * from param_eventosjogo;





/*************************************************
*tabela de logeventos
*esta tabela registrará todos os eventos do jogo
*desde o login até a navegacao geral dentro do
*jogo esta sendo monitorada por esta tabela
**************************************************/
create table log_eventos(
log_eventos_id              double precision not null primary key auto_increment,
log_eventos_missao_id       integer not null,
log_eventos_eventosjogo     integer not null,
log_eventos_descricao       text,
log_eventos_ip              text,
log_eventos_data            timestamp not null default now()
);
select * from log_eventos;



/*************************************************
*tabela de parametros com os episodios para o jogo
**************************************************/
create table param_episodios(
param_episodios_id        integer not null primary key auto_increment,
param_episodios_nome      character varying(255) not null,
param_episodios_ativo     boolean not null default true
);
insert into param_episodios(param_episodios_nome)values('Knee-Deep In The Dead'),('The Shores Of Hell'),('Hell'),('Thy Flesh Consumed');
select * from param_episodios;



/*************************************************
*tabela de parametros com os mapas para o jogo, tabela esta relacionada
*com a tabela de episodios
**************************************************/
create table param_mapas(
param_mapas_id            integer not null primary key auto_increment,
param_mapas_episodios_id  integer not null,
param_mapas_nome          character varying(255) not null,
param_mapas_ativo         boolean not null default true,
FOREIGN KEY         (param_mapas_episodios_id)
REFERENCES          param_episodios(param_episodios_id)
ON UPDATE CASCADE
ON DELETE RESTRICT
);
insert into param_mapas(param_mapas_episodios_id,param_mapas_nome)values(1,'Hangar'),(1,'Nuclear Plant'),(1,'Toxin Refinery'),(1,'Military Base'),(1,'Command Control'),
(1,'Phobos Lab'),(1,'Central Processing'),(1,'Computer Station'),(1,'Phobos Anomaly'),(2,'Deimos Anomaly'),(2,'Containment Area'),(2,'Refinery'),
(2,'Deimos Lab'),(2,'Command Center'),(2,'Fortress of Mystery'),(2,'Halls of the Damned'),(2,'Spawning Vats'),(2,'Tower of Babel'),(3,'Hell Keep'),
(3,'Slough of Despair'),(3,'House of Pain'),(3,'Unholy Cathedral'),(3,'Mt. Erebus'),(3,'Gate to Limbo'),(3,'Gate to Limbo'),(3,'Dis'),(4,'Perfect Hatred'),
(4,'Fear'),(4,'Sever The Wicked'),(4,'They Will Repent'),(4,'Against Thee Wickedly'),(4,'And Hell Followed'),(4,'Unto The Cruel');
select * from param_mapas;



/*************************************************
*tabela de todas as armas disponiveis no jogo, estao cadastradas aqui
armas_id                    id da arma
armas_nome                  nome da arma
armas_dano                  quantidade de dano = quantidade de vida que é tirado do adversário quando se usa a respectiva arma
armas_quantidade_municao    quantidade de recursos que é usado na arma, punhos e motoserra =0
armas_ativo                 true = arma ativa para jogador poder selecionar
**************************************************/
create table param_armas(
param_armas_id                    integer not null primary key auto_increment,
param_armas_nome                  character varying(250) not null,
param_armas_dano                  integer not null,
param_armas_quantidade_municao    integer not null,
param_armas_ativo                 boolean not null default true
);
insert into param_armas(param_armas_nome,param_armas_dano,param_armas_quantidade_municao)values
('Fist',2,0),('Pistol',5,0),('Chainsaw',10,0),('Shotgun',10,8),('Chaingun',12,20),('Rocket Launcher',15,2),
('Plasma Gun',20,40),('BFG 9000',30,40);
select * from param_armas;



/*************************************************
*tabela que contém todos os itens que o jogador conseguiu no decorrer
* do jogo.
jogadoritens_id_itens        id do item
jogadoritens_missao_id       id da missao que o jogador esta jogando atualmente
jogadoritens_id_jogador      id do jogador
jogadoritens_valor           qtde do item em questao
jogadoritens_data            data que o jogador pegou o item
**************************************************/
create table dados_jogadoritens(
dados_jogadoritens_id_itens        integer not null primary key auto_increment,
dados_jogadoritens_missao_id       integer not null,
dados_jogadoritens_id_jogador      integer not null,
dados_jogadoritens_valor           integer not null,
dados_jogadoritens_data            timestamp not null default now()
);
select * from dados_jogadoritens;



/*************************************************
*tabela que contém todas as armas que o jogador conseguiu no decorrer do jogo
jogadorarmas_id_arma         id da arma
jogadorarmas_missao_id       id da missao que o jogador esta jogando atualmente
jogadorarmas_id_jogador      id do jogador
jogadorarmas_municao         qtde de munição
jogadorarmas_data            data que o jogador pegou a arma
**************************************************/
create table dados_jogadorarmas(
dados_jogadorarmas_id_arma         integer not null primary key auto_increment,
dados_jogadorarmas_missao_id       integer not null,
dados_jogadorarmas_id_jogador      integer not null,
dados_jogadorarmas_municao         integer not null,
dados_jogadorarmas_data            timestamp not null default now()
);
select * from dados_jogadorarmas;



/*************************************************
*tabela de parametros que contém todos os itens disponíveis no jogo
cadastro de todos os itens que existem no jogo

itens_id              id do item
itens_nome            nome do item
itens_valor           valor nao monetario, em quantidade de porção do item
itens_caracteristica  descrição do que é o item e o que ele faz
**************************************************/
create table param_itens(
param_itens_id              integer not null primary key auto_increment,
param_itens_nome            character varying(250) not null,
param_itens_tipo            integer not null,
param_itens_valor           integer not null,
param_itens_caracteristica  text not null
);
insert into param_itens
(param_itens_nome,param_itens_tipo,param_itens_valor,param_itens_caracteristica)
values
('Bullet Clip',1,10,'Armas: Pistola e Metralhadora Giratória.'),
('Shotgun Shells',1,4,'Cápsulas de Espingarda'),
('Rocket',1,4,'Lança-Foguetes'),
('Energy Cell',1,20,'Célula de Energia '),
('Box of Bullets',1,50,'Caixa de Balas'),
('Box of Shotgun Shells',1,20,'Caixa de Cápsulas de Espingarda'),
('Box of Rockets',1,20,'Caixa de Foguetes'),
('Box of Rockets',1,5,'Caixa de Foguetes'),
('Energy Cell Pack',1,100,'Bateria de Energia'),
('Health Bonus',2,1,'Bônus de Saúde, uma ampola azul. Restaura 1% da saúde do jogador até o máximo de 200%.'),
('Stimpack',2,1,'Curativo uma pequena caixa branca contendo o símbolo da Cruz Vermelha. Restaura 10% da saúde do jogador até o máximo de 100%.'),
('MediKit',2,10,'Estojo Médico um estojo branco contendo o símbolo da Cruz Vermelha. Restaura 25% da saúde do jogador até o máximo de 100%.'),
('Armor Bonus',2,1,'Bônus de Armadura  um capacete militar que emite um brilho interior verde. Restaura 1% da proteção do jogador até o máximo de 200%.'),
('Armor',2,100,'Armadura  um colete balístico militar na cor verde-fluorescente. Restaura instantaneamente a proteção do jogador para 100%, caso esteja menor, e não poderá ser coletada se já estiver igual ou maior a 100%.'),
('Mega Armor',2,100,'Mega Armadura  semelhante à Armadura, mas na cor azul. Eleva instantaneamente a proteção do jogador ao máximo de 200% em qualquer circunstância.'),
('Soulsphere',2,100,'Esfera da Alma  uma esfera cristalina na cor azul-marinho encapsulando uma face aparentemente humanóide. Ao ser coletada, adicionará instantaneamente 100 pontos à saúde atual do jogador até o máximo de 200%. Caso a saúde do jogador já esteja acima de 100%, a esfera fará efeito somente até o valor de 200%.'),
('Megasphere',2,100,'Mega Esfera  esfera cristalina similar à Esfera da Alma, mas na cor marrom e encapsulando uma face demoníaca similar à do inimigo Mancubus (ver mais acima). Uma vez coletada, elevará instantaneamente tanto a saúde quanto a proteção do jogador ao máximo de 200%, tornando-a assim um dos objetos mais raros e eficientes do jogo.'),
('Keys',3,0,'Chaves sem dúvida o objeto mais importante do jogo, elas são cruciais para completar cada missão. O jogador precisará explorar áreas e resolver enigmas presentes nos mapas de modo a obter as chaves para completar suas missões. Se houver uma porta trancada ou objeto que não puder ser manuseado normalmente, aparecerá uma mensagem dizendo que você precisará obter a chave daquela determinada cor para então abrir a porta ou manusear o objeto. As chaves existem nas cores vermelha, amarela e azul, nas formas de cartão magnético (Keycard) e caveira (Skullkey).'),
('Backpack',3,0,'Mochila este item não muito freqüente no jogo é uma mochila marrom em estilo militar. Uma vez adicionada, permite ao jogador armazenar o dobro da capacidade natural de munições para suas armas - ou seja, 400 balas de pistola e chaingun, 100 cartuchos de espingarda, 100 mísseis e 600 projéteis de energia plásmica. O efeito da mochila dura até o final do episódio em que foi coletada.'),
('Berserk',3,0,'Super Soco objeto exatamente igual ao Estojo Médico, sendo na cor preta em lugar de branco. Ao ser coletado, produz uma tela avermelhada (semelhante ao momento em que o jogador é atingido por um ataque inimigo) que dura alguns segundos. Ele não apenas restaura imediatamente a saúde do jogador a 100%, caso esteja menor, como também torna o soco (arma primária do jogador) até 10 vezes mais forte, sendo útil para destruir inimigos com pouca saúde com apenas alguns poucos golpes, como seu nome implica. O poder deste objeto durará somente até o término da missão em que for coletado.'),
('Computer Area Map',3,0,'Mapa Computadorizado aparece como uma espécie de monitor de vídeo na cor cinza com uma tela verde e botões de controle azuis. Este objeto torna nítidas todas as áreas exploradas e não exploradas (exceto áreas secretas e outras configuradas para não serem mostradas) do mapa, tecla Tab, facilitando a navegação. O efeito terminará ao ser completada a missão.'),
('Invulnerability',3,0,'Invulnerabilidade uma esfera cristalina verde contendo uma face maligna com olhos vermelhos. Este objeto tornará o jogador por 30 segundos completamente invencível a ataques inimigos e armadilhas dos cenários, como pisos tóxicos e paredes esmagadoras por exemplo, mas não invulnerável a telefrag (acontece quando um objeto é teletransportado ao local exato onde se encontra outro objeto, resultando na imediata destruição do segundo). Enquanto este objeto estiver ativo, todas as cores do display do jogo estarão invertidas monocromaticamente, e os olhos do personagem na barra de status, na parte de baixo da tela, emitirão um brilho dourado. Este efeito das cores invertidas é perfeito para enxergar em áreas escuras e visualizar inimigos invisíveis, como os Espectros. Cinco segundos antes de expirar o efeito do objeto, as cores da tela começarão a piscar, sinalizando o fim da imortalidade.'),
('Light Amplification Visor',3,0,'Visor de Iluminação tem a forma de um visor prateado com lentes vermelhas. Este objeto iluminará fortemente todas as áreas do mapa, inclusive as mais escuras, por aproximadamente 120 segundos, quando 5 segundos antes de seu efeito acabar as luzes piscarão, indicando seu término. Objeto bastante útil também para ver inimigos invisíveis, como Espectros.'),
('Partial Invisibility',3,0,'Invisibilidade Parcial é uma esfera cristalina vermelha com um tipo de olho azul pulsante dentro. Como indica seu nome, ela torna o jogador parcialmente invisível (de forma similar aos Espectros) por 60 segundos. Ao contrário do que muitos jogadores pensam, pegar este objeto com outro igual já ativo não adicionará 60 segundos de invisibilidade, mas meramente reiniciará o tempo de invisibilidade de volta aos 60 segundos iniciais. A grande vantagem deste objeto é a de não alertar inimigos próximos ou de confundir inimigos ativos, fazendo-os errar seus ataques. O corpo do jogador piscará em suas cores normais quando faltarem apenas 5 segundos para dissipar a invisibilidade.'),
('Radiation-Shielding Suit',3,0,'Traje Anti-Radiação aparece como uma roupa anti-biológica branca. Ao ser utilizada, cria uma tela verde (similar à tela vermelha criada pelo objeto Super Soco) que protege totalmente o jogador contra ambientes perigosos, como pisos tóxicos. A proteção do traje dura 60 segundos, e similarmente à Invisibilidade Parcial, vestir um segundo traje sobre um já ativo irá retornar o efeito aos 60 segundos iniciais. A tela verde piscará quando restarem apenas 5 segundos para encerrar a proteção do traje.');
select * from param_itens;



/*************************************************
*tabela que contém todos os inimigos do jogo
cadastro de todos os inimigos do jogo

inimigos_id              id do inimigo
inimigos_nome            nome do inimigo
inimigos_dano            quantidade de dano que ele pode causar em cada ataque
inimigos_total_vida      total de vida que o inimigo em questão possui dentro do jogo
inimigos_caracteristica  breve descrição de quem é o inimigo e o que ele pode fazer
**************************************************/
create table param_inimigos(
param_inimigos_id              integer not null primary key auto_increment,
param_inimigos_nome            character varying(250) not null,
param_inimigos_dano            integer not null,
param_inimigos_total_vida      integer not null,
param_inimigos_caracteristica  text not null
);
insert into param_inimigos
(param_inimigos_nome,param_inimigos_dano,param_inimigos_total_vida,param_inimigos_caracteristica)
values
('Zombieman',2,10,'o inimigo humano mais comum do jogo, presente em todos os episódios. É um soldado normal sem grandes traços chamativos, exceto pelo cabelo verde, possivelmente modificado por lixo tóxico ou influências infernais. Veste uma roupagem militar básica branca sem qualquer tipo de proteção exterior. Relativamente fraco, carrega um simples rifle de assalto que dispara por vez um único tiro que causa poucos danos, mesmo a um alvo sem blindagem. Ao ser morto, abandona um pente de balas para pistola e metralhadora.'),
('Shotgunner',5,15,'mais forte e durável que o Zumbi (e possivelmente com uma patente superior, daí seu nome), o Sargento é um outro tipo de soldado humano calvo, veste uma roupagem militar mais resistente na cor preta (repleta de manchas de sangue, inclusive nas mãos) e carrega uma espingarda, que, embora um pouco menos potente que a espingarda utilizada pelo jogador, ainda pode causar estragos muito grandes, principalmente nos tiros à queima-roupa. Ao ser morto, este inimigo deixa para trás sua espingarda.'),
('Imp',8,25,'o ser infernal mais comum do jogo, também aparecendo em todos os episódios, é um demônio humanóide com pele marrom imitando couro, olhos vermelhos, garras afiadas nas mãos e pés e espinhos ósseos protuberantes em todo o corpo. Possui dois ataques distintos, sendo um atirar bolas de fogo à média e longa distância e o outro atacar suas vítimas de perto com as garras de suas mãos. Não possui muita duração física, podendo ser facilmente abatido com um tiro de espingarda à curta distância.'),
('Pinky Demon',10,25,'outro monstro relativamente comum no jogo, este ser é mais musculoso, com costas curvadas, braços pequenos mas fortes, chifres pontudos "apontando" para a frente, olhos dourados, pés de aspecto caprino e uma enorme boca cheia de dentes imensos. Este inimigo possui apenas um ataque, o de morder seus inimigos em mano-a-mano, porém possui maior velocidade que outros inimigos, dando-lhe assim a vantagem de cobrir grandes distâncias mais rapidamente. Sua cobertura muscular confere mais resistência e saúde, tornando-o um oponente formidável até mesmo aos soldados mais endurecidos em combate. O nome "Pinky" ("rosado" em inglês) vem da coloração cor-de-rosa de seu corpo.'),
('Spectre',12,50,'esta criatura é exatamente o mesmo que o Demônio, seja em aparência, sons e atributos. A única diferença é que o Espectro possui um poder fixo de invisibilidade parcial, tornando-o mais perigoso pelo fato de usar uma "coloração" cristalina escura - algo como uma lente transparente com "linhas de interferência" -, o que o torna quase impossível de ser visualizado em ambientes muito escuros, preferindo emboscar inimigos descuidados em tais lugares.'),
('Baron of Hell',15,75,'eles fazem sua estréia como chefes do primeiro episódio (sendo nesta ocasião apelidados "The Bruiser Brothers" ("Irmãos Destruidores"), numa referência aos irmãos Mario e Luigi, criados por Shigeru Miyamoto), reaparecendo normalmente como inimigos normais nos episódios posteriores. Barões do Inferno são sátiros antropomórficos com torso, chifres e pés de bode - algo como uma depictação visual de Baphomet -, além de mãos enormes com longas garras recurvadas e envoltas em ectoplasma verde. Similarmente aos Ímpios, estes monstros atiram projéteis de energia verde à média e longa distância e rasgam suas vítimas com suas garras de perto.'),
('kakodaimon',8,50,'(kakodaimon, que significa "Espírito Feio"), este demônio possui um corpo esférico que flutua no ar, adornado de escamas vermelhas, chifres ósseos de diversos tamanhos, um único olho verde e uma boca gigantesca com interior azulado repleta de dentes imensos. Embora movimente-se com lentidão, pode ser um inimigo perigoso pois ataca de ângulos inesperados ou improváveis (especialmente de cima), cuspindo bolas de matéria incandescente à média ou longa distância e mordendo suas vítimas de perto. Sua capacidade de flutuar no ar permite-lhe alguma vantagem com relação a outras criaturas inimigas. Uma curiosidade incomum entre os jogadores incluí ser este um dos mais amados e icônicos demônios do jogo, devido ao seu aspecto simples e característico. Bichos de pelúcia e fanarts já foram criados em sua homenagem.'),
('Lost Soul',8,50,'este demônio tem o aspecto de um crânio com chifres e uma "cabeleira" de fogo infernal em sua nuca e olhos. Levita no ar, assim como o Cacodemon. Seu único meio de ataque consiste em alinhar-se frontalmente com seu alvo e investir velozmente contra ele, colidindo fisicamente com grande impacto. Almas Perdidas não são fisicamente muito fortes e seu ataque causa apenas danos moderados, podendo ser facilmente derrotadas com alguns poucos golpes. Geralmente aparecem em grupos para compensar seu baixo potencial ofensivo.'),
('Cyberdemon',15,100,'o chamado "guerreiro mais poderoso do inferno" estréia como chefe do segundo episódio, reaparecendo muito raramente nos demais episódios. O Cyberdemon é basicamente uma encarnação gigante do Barão do Inferno (com especulados seis metros de altura) com um buraco em seu estômago, perna direita biônica e um canhão lançador de mísseis no lugar de seu braço esquerdo. Seu único ataque consiste em disparar de seu canhão de braço sucessões de três mísseis consecutivos, após isso o monstro movimenta-se um pouco mais antes de retomar o ataque. Cada míssil possui vasta área de danos e é poderoso o suficiente para matar numa só explosão até o jogador mais bem blindado. Cyberdemons pisam audivelmente com sua perna prostética ao caminhar, e ao serem derrotados dissolvem-se em nuvens de sangue e carne, sobrando somente os cascos ensanguentados de seus pés. Dado o poder de seus mísseis, um único Cyberdemon pode muitas vezes dizimar sozinho diversos inimigos.'),
('Spiderdemon',20,100,'possivelmente o "cérebro" maligno por trás da invasão dos demônios, é o chefe final do jogo (visto ser o chefe do terceiro episódio e, igualmente, do quarto episódio em Ultimate Doom). Caracteriza-se por ser um enorme cérebro (literalmente para seu nome) com rosto demoníaco e dois braços atarracados, montado sobre um tipo de chassis de aço com quatro pernas robóticas em estilo aracnídeo e uma metralhadora giratória instalada sob seu queixo. A Aranha Rainha tem um ataque contínuo (ou seja, ele dispara sua metralhadora continuamente contra seu alvo após avistá-lo, parando de atacar somente ao matar seu alvo, ser ferida ou morta por ele ou até o alvo sair de seu raio visual), e, assim como o Cyberdemon, também faz sons metálicos durante sua movimentação.');
select * from param_inimigos;




/*************************************************
*tabela que contem todas as ações do jogador dentro
*do jogo e tudo que ocorre no sistema de batalhas

logjogo_id                      id de registro sequencial da tabela
logjogo_missao_id              id da missao
logjogo_jogador_id              id do jogador
logjogo_episodio_id             id do episodio
logjogo_mapa_id                 id do mapa
logjogo_jogador_vida            quantidade de vida que o jogador possui atualmente
logjogo_qtde_inimigos_mortos    quantidade de inimigos que o jogador matou
logjogo_qtde_portas_secretas    quantidade de passagens e portas secretas que o jogador explorou
logjogo_data                    data do log

**************************************************/
create table log_jogo(
log_jogo_id                      double precision not null primary key auto_increment,
log_jogo_missao_id               integer not null,
log_jogo_jogador_id              integer not null,
log_jogo_episodio_id             integer not null,
log_jogo_mapa_id                 integer not null,
log_jogo_jogador_vida            integer not null,
log_jogo_qtde_inimigos_mortos    integer not null,
log_jogo_qtde_portas_secretas    integer not null,
log_jogo_data                    timestamp not null default now()
);
select * from log_jogo;







/*************************************************
*tabela de parametro que descreve o novo jogo
*ela conten informações de qual episodio começar
*qual mapa deve começar
**************************************************/
create table param_novojogo(
param_novojogo_id                integer not null primary key auto_increment,
param_novojogo_episodio          integer not null,
param_novojogo_mapa              integer not null,
param_novojogo_jogador           integer not null,
param_novojogo_data              timestamp not null default now()
);
select * from param_novojogo;





/*************************************************
*tabela de parametro que descreve o fuzileiro, como ele começa o jogo
**************************************************/
create table param_fuzileiro(
param_fuzileiro_id              integer not null primary key auto_increment,
param_fuzileiro_total_vida      integer not null,
param_fuzileiro_arma            integer not null
);
select * from param_fuzileiro;





/*************************************************
*tabela que descreve os tipos de itens disponíveis no jogo
**************************************************/
create table param_tipoitens(
param_tipoitens_id                integer not null primary key auto_increment,
param_tipoitens_descricao         character varying(255) not null,
param_tipoitens_ativo             boolean default true
);
insert into param_tipoitens
(param_tipoitens_descricao)
values
('Munição de Armas.'),
('Restauração de Saúde e proteção pessoal.'),
('Itens de Ambiente e Navegação do jogo.');
select * from param_tipoitens;




/*************************************************
*tabela de missão, significa que será criada uma nova linha nesta tabela
toda vez qeu o jogador clicar em new game!
missao_id           id da missao que o jogador esta iniciando/dando load
missao_jogador      id do jogador
missao_nome         nome que o jogador dará a missao
**************************************************/
create table dados_missao(
dados_missao_id           integer not null primary key auto_increment,
dados_missao_jogador      integer not null,
dados_missao_nome         character varying(255)
);
select * from dados_missao;





/*************************************************
*tabela de parametros de episodios e mapas do jogo relação
ao jogador.
roteiroepisodiomapa_id                  numero sequencial do roteiro e mapa do jogador
roteiroepisodiomapa_episodio            episodio que o jogador esta jogando
roteiroepisodiomapa_mapa                mapa que o jogador esta jogando
roteiroepisodiomapa_missao              missao atual que o jogador esta jogando
**************************************************/
create table param_roteiroepisodiomapa(
param_roteiroepisodiomapa_id                  integer not null primary key auto_increment,
param_roteiroepisodiomapa_episodio            integer not null,
param_roteiroepisodiomapa_mapa                integer not null,
param_roteiroepisodiomapa_missao              integer not null
);
select * from param_roteiroepisodiomapa;







/*************************************************
*tabela de parametros que contem a introducao com cada arquivo que sera chamado na
introducao do jogo, apos mostrar a introducao ou o jogador clicar em
pular introducao, a ultima linha desta tabela devera estar apontando para a abertura do
primeiro mapa do primeiro episodio.

introducaojogo_id                   numero sequencial das partes da introducao
introducaojogo_tpl                  arquivo de template que sera chamado para exibir a introducao
introducaojogo_descricao            descricao do tpl que sera exibido
introducaojogo_ativo                se o tpl esta ativo

falta colunas:
-do texto para o jogador ler a introdução do jogo
-url do video (se houver)
-url das imagens (se houver)

**************************************************/
create table param_introducaojogo(
param_introducaojogo_id                  integer not null primary key auto_increment,
param_introducaojogo_tpl                 character varying(255),
param_introducaojogo_descricao           integer not null,
param_introducaojogo_ativo               boolean default true
);
select * from param_introducaojogo;







/*************************************************
*tabela de parametros, que mostrara o que acontece
desde o primeiro mapa do primeiro episodio até o ultimo
mapa do ultimo episodio.

cada linha desta tabela é uma interação do jogador com o jogo.

param_roteirodemissoes_id                 id sequancial de cada ação da missão em questão
param_roteirodemissoes_mapa               é o id relacionado com a param_mapas
param_roteirodemissoes_episodio           é o id relacionado com a param_episodios
param_roteirodemissoes_urlimg             deve ser inserido a imagem do cenario em que o jogador esta passando no momento
param_roteirodemissoes_textojogo          texto em que o jogo faz a narrativa com o jogador para posiciona-lo no jogo
param_roteirodemissoes_textoinimigo       texto do inimigo falando com o jogador
param_roteirodemissoes_textojogador       texto com as falas do jogador
param_roteirodemissoes_batalha            se este campo for true que dizer que o turno atual deve ser de batalhas
param_roteirodemissoes_batalhasequencia   id da sequencia de batalha que o jogador deve ir
*************************************************/
create table param_roteirodemissoes(
param_roteirodemissoes_id                 integer not null primary key auto_increment,
param_roteirodemissoes_mapa               integer not null,
param_roteirodemissoes_episodio           integer not null,
param_roteirodemissoes_urlimg             text,
param_roteirodemissoes_textojogo          text,
param_roteirodemissoes_textoinimigo       text,
param_roteirodemissoes_textojogador       text,
param_roteirodemissoes_batalha            boolean default false,
param_roteirodemissoes_batalhasequencia   integer
);
select * from param_roteirodemissoes;

-->interação sem batalha
insert into param_roteirodemissoes
(param_roteirodemissoes_mapa,param_roteirodemissoes_episodio,param_roteirodemissoes_urlimg,param_roteirodemissoes_textojogo,param_roteirodemissoes_textoinimigo,param_roteirodemissoes_textojogador,param_roteirodemissoes_batalha)
values
(1,1,'imagem.jpg','descrição do cenário onde o jogador esta e o que ele tem q fazer',null,null,false);

-->interação com batalha
insert into param_roteirodemissoes
(param_roteirodemissoes_mapa,param_roteirodemissoes_episodio,param_roteirodemissoes_urlimg,param_roteirodemissoes_textojogo,param_roteirodemissoes_textoinimigo,param_roteirodemissoes_textojogador,param_roteirodemissoes_batalha)
values
(1,1,'imagem.jpg',true,null,null,true,1);








/*************************************************
*tabela do sistema de batalhas
toda vez que o jogador for direcionado para o sistema de batalhas, devera ser realizada via por uma view como esta a saude do jogador
e a cada turno do jogo, devera ser novamente revisto se o jogador possui vida suficiente para que possa continuar no jogo.

param_sistemadebatalhas_id                 id sequencial de batalhas
param_sistemadebatalhas_batalhasequencia   id de batalha relacionado ao id que vem da param_roteirodemissoes_mapa
param_sistemadebatalhas_mapa               id da tabela de param_mapas
param_sistemadebatalhas_episodio           id da tabela param_episodios
param_sistemadebatalhas_urlimg             url da imagem do inimigo que o jogador esta enfrentando
param_sistemadebatalhas_textojogo          texto do jogo com a narrativa da batalha direcionada para o jogador
param_sistemadebatalhas_textoinimigo       texto do inimigo para o jogador
param_sistemadebatalhas_textojogador       texto do jogador para o inimigo
param_sistemadebatalhas_opcaoataque        opção de ataque
param_sistemadebatalhas_textodefesa        opção de defesa
param_sistemadebatalhas_textopegaritem     opção de pegar item
param_sistemadebatalhas_textofugir         opção de fugir
param_sistemadebatalhas_textoauxiliar      opção auxiliar
**************************************************/
create table param_sistemadebatalhas(
param_sistemadebatalhas_id                 integer not null primary key auto_increment,
param_sistemadebatalhas_batalhasequencia   integer not null,
param_sistemadebatalhas_mapa               integer not null,
param_sistemadebatalhas_episodio           integer not null,
param_sistemadebatalhas_urlimg             text,
param_sistemadebatalhas_textojogo          text,
param_sistemadebatalhas_textoinimigo       text,
param_sistemadebatalhas_textojogador       text,
param_sistemadebatalhas_opcaoataque        text,
param_sistemadebatalhas_textodefesa        text,
param_sistemadebatalhas_textopegaritem     text,
param_sistemadebatalhas_textofugir         text,
param_sistemadebatalhas_textoauxiliar      text
);
select * from param_sistemadebatalhas;




--select * from view_introducaojogo;
--
--CREATE or replace VIEW view_introducaojogo AS
--SELECT * FROM param_introducaojogo;
--
--drop view view_introducaojogo;





/*************************************************
*temos que criar uma tabela onde conterá todas as interações que o usuário
terá com o jogo.

->Introdução do jogo, pode ser um video onde ele poderá assistir ao video,
onde ele ficará interado como é o jogo e como ele poderá interagir como mesmo.
este video ele poderá assistir até o fim ou pular.
Deverá conter um texto dizendo aonde ele está, quem ele é, e o que deve fazer para
cumprir todas as missões(mapas).

->musicas de fundo devem ser de suspense, pode ser musicas do slayer, sepultura
e relacionados.

->mostrar a abertura do primeiro episodio e primeiro mapa

->desenvolver uma tabela que conterá todo o roteiro do jogo com as possibilidades
finitas da possibilidades a ser jogadas;

->criar tabela com o sistema de batalhas

->vamos precisar de tabelas temporárias???

->precisa fazer todos os relacionamentos de constraints foreing key

->temos que fazer o algoritml do jogo para definirmos melhor como o jogo será;

**************************************************/




/*MySqlMySqlMySqlMySqlMySqlMySqlMySqlMySqlMySqlMySqlMySqlMySqlMySqlMySqlMySqlMySql*/
