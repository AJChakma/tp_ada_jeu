with Ada.Text_IO;
use Ada.Text_IO;

package body Partie is
   
   procedure Joue_Partie (E : in out Etat; J : in Joueur) is
      Joueur_Courant : Joueur := J;
      Coup_Joue : Coup;
   begin
      
      --  Tant que l'on n'a pas atteint un état stable (gagnant ou nul), on continue le jeu
      while not (Est_Gagnant(E,Joueur_Courant) and Est_Nul(E)) loop
	 --  Sélection de la demande de coup en fonction du joueur
	 if (Joueur_Courant = Joueur1) then
	    Coup_Joue := Coup_Joueur1(E);
	 else
	    Coup_Joue := Coup_Joueur2(E);
	 end if;
	 
	 --  Mise à jour de l'état du jeu en fonction du coup joué
	 E := Etat_Suivant(E,Coup_Joue);
	 
	 --  Affichage du jeu et du coup joué
	 Affiche_Jeu(E);
	 Affiche_Coup(Coup_Joue);
	 
	 --  La main passe à l'adversaire
	 Joueur_Courant := Adversaire(Joueur_Courant);
      end loop;
      
      --  Affichage du gagnant ou du match nul
      Affichage_Fin_Partie(E,Joueur_Courant);      
      
   end Joue_Partie;
      
   
   procedure Affichage_Fin_Partie (E : in Etat; J : in Joueur) is
   begin
      if (Est_Nul(E)) then
	 Put_Line("Match nul !");
      elsif (Est_Gagnant(E,J)) then
	 if ( J =  Joueur1) then
	    Put_Line(Nom_Joueur1 & " a gagné !");
	 elsif ( J =  Joueur2) then
	    Put_Line(Nom_Joueur2 & " a gagné !");
	 end if;
      end if;	 
   end Affichage_Fin_Partie;
   
end Partie;
