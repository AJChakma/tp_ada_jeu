with Ada.Text_Io;use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Numerics.Discrete_Random;

package body Moteur_Jeu is
   
   use Liste_Coups;			--  Liste_Coups instancié dans .ads
   
       
    -- fonction interne au package qui dit si un état est terminal ou pas
   function Est_Terminal(E : Etat) return Boolean is
   begin
      return Est_Nul(E) or Est_Gagnant(E,JoueurMoteur) or Est_Gagnant(E,Adversaire(JoueurMoteur));
   end Est_Terminal;
   
   -- procedure d'affichage d'entiers
   procedure Affiche_Integer(I : in Integer) is
   begin
      Put(Integer'Image(I));
   end;


   -- Evaluation d'un coup a partir d'un etat donne
   -- E : Etat courant
   -- P : profondeur a laquelle cette evaluation doit etre realisee
   -- C : Coup a evaluer
   -- J : Joueur qui realise le coup
   function Eval_Min_Max(E : Etat; P : Natural; C : Coup; J : Joueur) return Integer is
      L : Liste_Coups.Liste;
      It : Iterateur;
      Val_Coup,Res : Integer;  --  Valeur du coup retournée
      ESuiv : Etat;			--  Etat suivant (pour la bcl de rec aussi)
      package Liste_Integer is new Liste_Generique(Integer,Affiche_Integer);
      L_Val_Coup : Liste_Integer.Liste;	--  Liste de valeurs de coup (entier)
      
      procedure Meilleur_Val_Coup(L : in out Liste_Integer.Liste; Res : out Integer) is
	 It : Liste_Integer.Iterateur;
      begin
	 It := Liste_Integer.Creer_Iterateur(L);
	 Liste_Integer.Suivant(It);
	 Res := Liste_Integer.Element_Courant(It); --  Init de Res avec la première valeur
	 while  Liste_Integer.A_Suivant(It) loop
	    --  On parcourt toutes les valeurs et on choisit la max (meilleure)
	    Liste_Integer.Suivant(It);
	    Res := Integer'Max(Res,Liste_Integer.Element_Courant(It));
	 end loop;
	 Liste_Integer.Libere_Iterateur(It);
	 Liste_Integer.Libere_Liste(L);
      end Meilleur_Val_Coup;
      
   begin
      if P = 0 then
	 --  On a atteint une feuille, on lance donc une évaluation statique
	return Eval(E,J);
      elsif Est_Terminal(E) then
	 --  état terminal mais profondeur pas atteinte
	 --Put_Line("Eval_Min_Max : Etat terminal");
	 if Est_Nul(E) then
	    return 0;
	 elsif Est_Gagnant(E,J) then
	    return Integer'Last;	--  Valeur max (donc positive) d'un type Integer
	 else
	    return Integer'First;	--  Valeur min (donc negative) d'un type Integer
	 end if;
      else
	 --  Autre cas (i.e pas sur une feuille et état pas terminale)
	 --Put_Line("Eval_Min_Max : Récursivité enclanché");
	 L_Val_Coup := Liste_Integer.Creer_Liste;
	 L := Creer_Liste;
	 L := Coups_Possibles(E,J);
	 --  !! L'iterateur doit etre créé aprés avoir rempli la liste à cause de l'élé fictif
	 It := Creer_Iterateur(L);
	 while A_Suivant(It) loop
	    Suivant(It);
	    --  Calcul de l'état suivant pour chaque coup possible
	    ESuiv := Etat_Suivant(E,C);	 
	    if J = JoueurMoteur then	--  le prochain coup sera joué par "moi"
	       Val_Coup := Eval_Min_Max(ESuiv,P-1,Element_Courant(It),Adversaire(J));
	    else			--  le prochain coup sera joué par l'adversaire
	       Val_Coup := -Eval_Min_Max(ESuiv,P-1,Element_Courant(It),Adversaire(J));
	    end if;
	    Liste_Integer.Insere_Tete(Val_Coup,L_Val_Coup);
	 end loop;
	 Libere_Iterateur(It);
	 Libere_Liste(L);
	 Meilleur_Val_Coup(L_Val_Coup,Res);
	 return Res;
      end if;
   end Eval_Min_Max;
   
   -- Choix du prochain coup par l'ordinateur. 
    -- E : l'etat actuel du jeu;
    -- P : profondeur a laquelle la selection doit s'effectuer
   function Choix_Coup(E : Etat) return Coup is
      
      C,Meilleur_Coup : Coup;
      L : Liste_Coups.Liste;			--  Liste des coups possibles
      It : Iterateur;			--  Itérateur sur la liste précédente
      L_Coups_Egaux : Liste_Coups.Liste;	--  Liste contenant les coups à valeurs égales
      It_L_Coups_Egaux : Iterateur;
      Nbr_Coups_Egaux : Positive := 1;	--  Compte le nombre de coups à valeurs égales
      Val_Coup : Integer;			--  Valeur de coup évalué
      Val_Meilleur_Coup : Integer := Integer'First; --  Valeur du meilleur coup
   begin
      --Initialisation des listes
      L_Coups_Egaux := Creer_Liste;
      L := Creer_Liste;
      L := Coups_Possibles(E,JoueurMoteur);	--  On récupère tous les coups possibles
      It := Creer_Iterateur(L);      
      --On evalue chaque coup
      while A_Suivant(It) loop
	 --Put_Line("Choix_Coup : Examen d'un Coup...");
	 Suivant(It);			--  évite l'élément fictif a la première bcl
	 C := Element_Courant(It);	--  Récupère le coup courant

	 Val_Coup := Eval_Min_Max(E,P,C,JoueurMoteur); --  Puis la valeur de ce coup

	 --  Put("Choix_Coup : Le coup vaux " & Integer'Image(Val_Coup));
	 --  New_Line;
	 if Val_Coup = Val_Meilleur_Coup then
	    -- Si le coup évalué et le meilleur coup ont la même valeur, on ajoute le coup
	    -- courant à la liste et on incrémente le nombre de coups égaux
	    Insere_Tete(C,L_Coups_Egaux);
	    Nbr_Coups_Egaux := Nbr_Coups_Egaux+1;
	 elsif Val_Coup > Val_Meilleur_Coup then
	    --  On a trouvé un nouveau meilleur coup, on l'enregistre ainsi que sa valeur
	    --  Pour la prochaine boucle
	    Meilleur_Coup := C;
	    Insere_Tete(Meilleur_Coup,L_Coups_Egaux);
	    Nbr_Coups_Egaux := 1;	--  Reset du nombre de coups égaux
	    Val_Meilleur_Coup := Val_Coup;
	 --else --if Val_Coup < Val_Meilleur_Coup
	    -- si il existe déjà un coup de valeur plus élevée, on ne fait rien
	 end if;
	 Put("Pour le coup :");
	 Affiche_Coup(C);
	 Put(", valeur :" & Integer'Image(Val_Coup));
	 New_Line;
      end loop;
      Libere_Iterateur(It);
      Libere_Liste(L);
      --  --------------------------------------------------------------------------------
      --  à ce stade on obtient : 
      --  	- Un entier Val_Meilleur_Coup qui est la valeur max Possible
      --  	- Une liste de coups de valeurs égales : Val_Meilleur_Coup
      --  	- Un Entier Nbr_Coups_Egaux qui représente le nombre de coups de valeurs égales
      --  --------------------------------------------------------------------------------
      --  Put("Choix_Coup : Nbr de coups égaux : " & Integer'Image(Nbr_Coups_Egaux));
      --  New_Line;
      if Nbr_Coups_Egaux > 1 then
	 declare
	    -- Les lignes suivantes génèrent un nombre aléatoire entre 1 et le nombre max de coups
	    subtype Intervalle is Positive range 1 .. Nbr_Coups_Egaux;

	    package Random_Positive is new Ada.Numerics.Discrete_Random(Intervalle);
	    use Random_Positive;
	    G : Generator;
	    Pos : Positive;
	    I : Natural :=0;
	 begin
	    --  Put("Choix_Coup : random  du coup entre 1 et " & Integer'Image(Nbr_Coups_Egaux));
	    --  New_Line;
	    Reset(G);	    
	    It_L_Coups_Egaux := Creer_Iterateur(L_Coups_Egaux);
	    --  On parcourt la liste un nombre aléatoire de fois pour choisir le coup
	    Pos := Random(G);
	    --  Put("Choix_Coup : coup choisit numéro" & Integer'Image(Pos));
	    --  New_Line;
	    loop
	       I := I+1;
	       --  Comme la valeur aléatoire minimum est 1, on sautera forcément l'élement fictif
	       Suivant(It_L_Coups_Egaux);
	       exit when (not A_Suivant(It_L_Coups_Egaux)) or I = Pos;
	    end loop;
	    C := Element_Courant(It_L_Coups_Egaux);
	    Libere_Iterateur(It_L_Coups_Egaux);
	 end;
      else				--  Il n'y a q'un seul meilleur coup
	 C := Meilleur_Coup;
      end if;
      Libere_Liste(L_Coups_Egaux);
      return C;
   end Choix_Coup;
end Moteur_Jeu;
