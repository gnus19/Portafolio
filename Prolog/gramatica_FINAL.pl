%--------------------------------------------
%          PARSER INGLES EN PROLOG
%--------------------------------------------
%
% Valida que una palabra en ingles este
% sintacticamente correcta.
%
%
% Ejecucion:
%   ---
%   palabra("I'm eat the apple").
%   true.
%   --
%   Palabra("Mary eat the apple and a chicken").
%   true.
%
% Comentarios:
%   Si considera que alguna oracion esta bien
%   escrita Y el interpretador NO la acepta
%   debera ingresar las primitivas en la
%   base de conocimientos
%
% Integrantes:
%   Jose Ignacio Palma (13-11044)
%   Andre Corcuera (12-10660)

%--------------------------------------------
% TERMINALES:
% -------------------------------------------
    % VERBOS:
    verboA1 --> ("give" ; "gave").
    verboA2 --> ("gives" ; "gave").
    verboP1 --> ("go"; "went").
    verboP2 --> ("goes"; "went").
    verboPR1 --> ("push"; "pushed").
    verboPR2 --> ("pushes"; "pushed").
    verboM1 --> ("kick"; "kicked").
    verboM2 --> ("kicks"; "kicked").
    verboG1 --> ("throw"; "threw"; "buy"; "bought"; "sell"; "sold").
    verboG2 --> ("throws"; "threw"; "buys"; "bought"; "sells"; "sold").
    verboI1 --> ("eat"; "ate").
    verboI2 --> ("eats"; "ate").
    verboE1 --> ("cry"; "cried").
    verboE2 --> ("cries"; "cried").
    verboEInf --> ("cry").
    verboMT1 --> ("say"; "said"; "tell"; "told").
    verboMT2 --> ("says"; "said"; "tells"; "told").
    verboMB1 --> ("choose"; "chose"; "decide"; "decided").
    verboMB2 --> ("chooses"; "chose"; "decides"; "decided").
    verboS --> ("rings"; "explodes"; "sounds").
    verboAT1 --> ("smell"; "taste"; "see"; "smelt"; "tasted"; "saw").
    verboAT2 --> ("smells"; "tastes"; "sees"; "smelt"; "tasted"; "saw").
    
    % CONJUGADOS:
    conjugados --> (" and ";" or ";", ").

    % SUJETOS
    suj1 --> ("I"; "You"; "We"; "They"; "I'm"; "I am"; "Mary"; "Johan"; "Peter"; "Jhan"; "Joseph").
    suj2 --> ("me"; "you"; "him"; "her"; "them"; "us"; "Mary"; "Johan"; "Peter"; "Jhan"; "Joseph").
    sujHSI --> ("He"; "She"; "It").
    lugares --> ("the station"; "the store"; "the house").
    objeto --> (
                "the ball"; 
                "the bottle"; 
                "the bucket"; 
                "the box"; 
                "the car"; 
                "the tv"; 
                "the carpet"; 
                "the console"; 
                "the game"; 
                "the video game"; 
                "a computer"
               ).
    comida --> ("the apple"; "the apples"; "an apple"; "the chicken"; "a chicken", "the fruit"; "the meat").
    animales --> ("the dogs"; "the dog"; "the cat"; "the cats"; "a dog"; "a cat"; "the monkey"; "a monkey").

% REGLAS:
% -------------------------------------------
    % PRIMITIVAS:
    atrans1 --> suj1, " ", verboA1, " ", suj2.
    atrans2 --> sujHSI , " ", verboA2, " ", suj2.
    atrans --> (atrans1 ; atrans2).

    ptrans1 --> suj1, " ", verboP1, " ", "to", " ", lugares.
    ptrans1 --> suj1, " ", verboP1, " ", "with ", suj2, " ", "to", " ", lugares.
    ptrans2 --> sujHSI, " ", verboP2, " ", "to", " ", lugares.
    ptrans2 --> sujHSI, " ", verboP2, " ", "with ", suj2, " ", "to", " ", lugares.
    ptrans --> (ptrans1; ptrans2).

    proprl1 --> suj1, " ", verboPR1, " ", suj2.
    proprl2 --> sujHSI, " ", verboPR2, " ", suj2.
    proprl --> (proprl1; proprl2).

    move1 --> suj1, " ", verboM1, " ", suj2.
    move1 --> suj1, " ", verboM1, " ", objeto.
    move2 --> sujHSI, " ", verboM2, " ", suj2.
    move2 --> sujHSI, " ", verboM2, " ", objeto.
    move --> (move1; move2).

    grasp1 --> suj1, " ", verboG1, " it".
    grasp1 --> suj1, " ", verboG1, " ", objeto, (""; " from ", suj2; " to ", suj2).
    grasp1 --> suj1, " ", verboG1, " ", suj2.
    grasp2 --> sujHSI, " ", verboG2, " it".
    grasp2 --> sujHSI, " ", verboG2, " ", objeto, (""; " from ", suj2; " to ", suj2).
    grasp2 --> sujHSI, " ", verboG2, " ", suj2.
    grasp --> (grasp1; grasp2).

    ingest1 --> suj1, " ", verboI1, " ", comida.
    ingest2 --> sujHSI, " ", verboI2, " ", comida.
    ingest2 --> animales, " ", verboI2, " ", comida.
    ingest --> (ingest1; ingest2).

    expel1 --> suj1, " ", verboE1.
    expel1 --> suj1, " made ", suj2, " ", verboEInf.
    expel2 --> sujHSI, " ", verboE2.
    expel2 --> sujHSI, " made ", suj2, " ", verboEInf.  
    expel --> (expel1; expel2).

    mtrans1 --> suj1, " ", verboMT1, " it".
    mtrans1 --> suj1, " ", verboMT1, " to ", suj2.
    mtrans2 --> sujHSI, " ", verboMT2, " it".
    mtrans2 --> sujHSI, " ", verboMT2, " to ", suj2.
    mtrans --> (mtrans1; mtrans2).

    mbuild1 --> suj1, " ", verboMB1, " it".
    mbuild1 --> suj1, " ", verboMB1, " ", objeto.
    mbuild2--> sujHSI, " ", verboMB2, " it".
    mbuild2 --> sujHSI, " ", verboMB2, " ", objeto.
    mbuild --> (mbuild1; mbuild2).

    speak1 --> mtrans.
    speak2 --> "It ", verboS. 
    speak --> (speak1; speak2).

    attend1 --> suj1, " ", (verboAT1; "feel"), " ", ("good"; "bad"; "terrible"; "nice"; "great"; "awful"; "it").
    attend1 --> suj1, " ", verboAT1, " ", comida.
    attend1 --> suj1, " ", ("touch"; "see"; "hear"), " ", (objeto; animales).
    attend2 --> sujHSI, " ", (verboAT2; "feels"), " ", ("good"; "bad"; "terrible"; "nice"; "great"; "awful"; "it").
    attend2 --> sujHSI, " ", verboAT2, " ", comida.
    attend2 --> sujHSI, " ", ("touches"; "sees"; "hears"), " ", (objeto; animales).
    attend --> (attend1; attend2).

% SENTENCIAS:
% -------------------------------------------
    % SIMPLES
    sentence --> (atrans; ptrans; proprl; move; grasp; ingest; expel; mtrans; mbuild; speak; attend).

    % CONJUGADAS
    conjugado--> sentence,conjugados,conjugado,!.
    conjugado--> sentence,conjugados,(suj1;suj2;sujHSI;lugares;objeto;comida;animales),!.
    conjugado --> sentence,!.

% PALABRA
% -------------------------------------------
palabra(S) :- string_codes(S,U),conjugado(U, []),!.
