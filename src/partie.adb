with Ada.Text_IO;
use Ada.Text_IO;

package body Partie is
   
   procedure Joue_Partie (E : in out Etat; J : in Joueur) is
      Joueur_Courant : Joueur := J;
      Coup_Joue : Coup;
   begin
      
      --  Tant que l'on n'a pas atteint un état stable (gagnant ou nul), on continue le jeu
      while not (Est_Gagnant(E,Joueur_Courant) or else Est_Gagnant(E,Adversaire(Joueur_Courant)) or else Est_Nul(E)) loop
	 --  Affichage du jeu
	 Affiche_Jeu(E);
	 
	 --  Sélection de la demande de coup en fonction du joueur
	 if (Joueur_Courant = Joueur1) then
	    Put(Nom_Joueur1 & " : ");
	    Coup_Joue := Coup_Joueur1(E);
	 else
	    Put(Nom_Joueur2 & " : ");
	    Coup_Joue := Coup_Joueur2(E);
	 end if;
	 
	 --  Affichage du coup joué
	 Affiche_Coup(Coup_Joue);
	 
	 --  Mise à jour de l'état du jeu en fonction du coup joué
	 E := Etat_Suivant(E,Coup_Joue);	 	 
	 
	 --  La main passe à l'adversaire
	 Joueur_Courant := Adversaire(Joueur_Courant);
	 
      end loop;
      
      --  Affichage du jeu et du gagnant ou du match nul
      Affiche_Jeu(E);
      Affichage_Fin_Partie(E,Joueur_Courant);      
      
   end Joue_Partie;
      
   
   procedure Affichage_Fin_Partie (E : in Etat; J : in Joueur) is
   begin
      if (Est_Nul(E)) then
	 Put_Line("Match nul !");
      elsif (Est_Gagnant(E,J) and J = Joueur1) then
	 Put_Line(Nom_Joueur1 & " a gagné !");
      elsif (Est_Gagnant(E,Adversaire(J))) then
	 Put_Line(Nom_Joueur2 & " a gagné !");
      else
	 Put_Line("Mauvaise utilisation de la procedure Affichage_Fin_Partie : pas d'état final !");
      end if;	 
   end Affichage_Fin_Partie;
   
end Partie;
