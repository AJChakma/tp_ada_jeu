with Ada.Text_IO;
use Ada.Text_IO;

package body Puissance4 is
   
   procedure Initialiser(E: in out Etat) is
   begin
      --  Initialisation de la matrice de jeu par le caractère vide
      for I in E'Range loop
	 for J in I'Range loop
	    J := ' ';
	 end loop;
      end loop;     
      
   end Initialiser;
   
   
   function Demande_Coup_Joueur1(E : Etat) is
      Coup_Joue : Coup;
   begin
      Put(Nom_Joueur1 &te " : ");
      Get_Integer(Coup_Joue.Indice_Colonne);
      Coup_Joue.Symbole := 'X';
      return Coup_Joue;
   end Demande_Coup_Joueur1;
   
   
   function Demande_Coup_Joueur2(E : Etat) is
      Coup_Joue : Coup;
   begin
      Put(Nom_Joueur2 & " : ");
      Get_Integer(Coup_Joue.Indice_Colonne);
      Coup_Joue.Symbole := 'O';
      return Coup_Joue;
   end Demande_Coup_Joueur2;
   
   
   function Est_Gagnant(E :Etat; J : Joueur) is
      Voisins : Integer := 0;      
   begin
      for 
   end Est_Gagnant;
   
   
   function Est_Nul(E :Etat; J : Joueur) is
      
   begin
      
   end Est_Nul;
   
   
   function Jouer(E : Etat; C : Coup) is
      Indice_Case_Libre : Integer;
      Etat_Res : Etat := E;
   begin      
      while not (Indice_Case_Libre = Recherche_Case_Libre(C.Indice_Colonne)) loop
	 Put_Line("La colonne est pleine, veuillez en choisir une autre !");
	 if (C.Symbole = 'X') then
	    Demande_Coup_Joueur1(E);
	 else
	    Demande_Coup_Joueur2(E);
	 end if;
      end loop;
      
      Etat_Res(C.Indice_Colonne)(Indice_Case_Libre) := C.Symbole;
      
      return E;
   end Jouer;
   
   
   function Recherche_Case_Libre(C : Colonne) is
   begin
      --  On renvoit 0 si on n'a trouvé aucune case libre
      for I in 1..Hauteur loop
	 if (C(I) = ' ') then	    
	    return I;
	 end if;
      end loop;
      return 0;      
   end Recherche_Case_Libre;

end Puissance4;
