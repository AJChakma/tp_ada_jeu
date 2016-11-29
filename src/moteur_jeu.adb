

package body Moteur_Jeu is
   
   use Liste_Coups;			--  Liste coup instancié dans .ads
   
       
    -- fonction intern au package dit si un état est terminal ou pas
   function Est_Terminal(E : Etat) return Boolean is
   begin
      return Est_Nul(E) or Est_Gagnant(E,JoueurMoteur) or Est_Gagnant(E,Adversaire(JoueurMoteur));
   end Est_Terminal;

   -- Evaluation d'un coup a partir d'un etat donne
   -- E : Etat courant
   -- P : profondeur a laquelle cette evaluation doit etre realisee
   -- C : Coup a evaluer
   -- J : Joueur qui realise le coup
   function Eval_Min_Max(E : Etat; P : Natural; C : Coup; J : Joueur) return Integer is
      L : Liste_Coups.Liste;
      It : Iterateur;
      IRes : Integer;			--  Resulta à retourner
      --ITmp : Integer;			--  Pour la boucle de récurcivité
      ESuiv : Etat;			--  Etat suivant (pour la bcl de rec aussi)
   begin
      if P = 0 then
	 --  On a atteint une feuille, on lance donc une évaluation statique
	return Eval(E);
      elsif Est_Terminal(E) then
	 --  état terminale mais profondeur pas atteinte
	 if Est_Nul(E) then
	    return 0;
	 elsif Est_Gagnant(E,J) then
	    return Integer'Last;	--  Valeur max (donc positive) d'un type Integer
	 else
	    return Integer'First;	--  Valeur min (donc negative) d'un type Integer
	 end if;
      else
	 --  Autre cas (i.e pas sur une feuille et état pas terminale)
	 L := Creer_Liste;
	 L := Coups_Possibles(E,J);
	 --  !! L'iterateur doit etre crée aprés avoir remplis la liste à cause de l'élé fictif
	 It := Creer_Iterateur(L);
	 while A_Suivant(It) loop
	    Suivant(It);
	    --  Calcule de l'état suivant pour chaque coup possible
	    ESuiv := Etat_Suivant(E,C);
	    --  Appel récurcife à la fonction, pour chaque coups possibleset leurs états associés
	    --  ITmp := Eval_Min_Max(ESuiv,P,L.Ele,J);
	    --  if ITmp > IRes then
	    --     --  Si le coup est mieu "noté" ont garde sont résulta (cas prochain coup au joueur)
	    --     IRes := ITmp;
	    --  end if;	 
	    
	    IRes := Integer'Max(IRes,Eval_Min_Max(ESuiv,P,Element_Courant(It),J));
	 end loop;
	 Libere_Iterateur(It);
	 Libere_Liste(L);
	 
	 return IRes;
      end if;
   end Eval_Min_Max;
   
   -- Choix du prochain coup par l'ordinateur. 
    -- E : l'etat actuel du jeu;
    -- P : profondeur a laquelle la selection doit s'effetuer
   function Choix_Coup(E : Etat) return Coup is
      C : Coup;
   begin
      ----------------------
      -- A compléter !
      ----------------------
       return C;
   end Choix_Coup;
end Moteur_Jeu;
