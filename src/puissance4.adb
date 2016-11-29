with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;

package body Puissance4 is
   
   procedure Initialiser(E: in out Etat) is
   begin
      --  Initialisation de la matrice de jeu par le caractère vide
      --  Précision : E est d'abord indexé par les colonnes puis par les lignes
      for J in E'Range loop
	 for I in E(J)'Range loop
	    E(J)(I) := ' ';
	 end loop;
      end loop;     
   end Initialiser;
   
   function Jouer(E : Etat; C : Coup) return Etat is
      Indice_Case_Libre : Integer;
      Etat_Res : Etat := E;
      Coup_Joue : Coup := C;
   begin      
      --  On vérifie que la colonne demandée n'est pas pleine
      while Recherche_Case_Libre(E,Coup_Joue.Indice_Colonne) = 0 loop
	 Put_Line("La colonne est pleine, veuillez en choisir une autre !");
	 if (Coup_Joue.Symbole = 'X') then
	    Coup_Joue := Demande_Coup_Joueur1(E);
	 else
	    Coup_Joue := Demande_Coup_Joueur2(E);
	 end if;
      end loop;
      
      Indice_Case_Libre := Recherche_Case_Libre(E,Coup_Joue.Indice_Colonne);
      Etat_Res(Coup_Joue.Indice_Colonne)(Indice_Case_Libre) := Coup_Joue.Symbole;
      
      return Etat_Res;
   end Jouer;
   
   
   function Demande_Coup_Joueur1(E : Etat) return Coup is
      Coup_Joue : Coup;
   begin
      Put("Numéro de colonne : ");
      Get(Coup_Joue.Indice_Colonne);
      Coup_Joue.Symbole := 'X';
      return Coup_Joue;
   end Demande_Coup_Joueur1;
   
   
   function Demande_Coup_Joueur2(E : Etat) return Coup is
      Coup_Joue : Coup;
   begin
      Put("Numéro de colonne : ");
      Get(Coup_Joue.Indice_Colonne);
      Coup_Joue.Symbole := 'O';
      return Coup_Joue;
   end Demande_Coup_Joueur2;
   
   
   function Est_Gagnant(E :Etat; J : Joueur) return Boolean is
      Voisins_Colonne : Integer := 0;      
      Voisins_Ligne : Integer := 0;
      Voisins_Diagonale : Integer := 0;
      Ligne_Diagonale : Integer;
      Colonne_Diagonale : Integer;
      Symbole_Joueur : Character;      
   begin
      if (J = Joueur1) then
	 Symbole_Joueur := 'X';
      else
	 Symbole_Joueur := 'O';
      end if;
      
      --  Boucle de recherche par colonne
      for J in E'Range loop
	 for I in E(J)'Range loop
	    if (Voisins_Colonne = Nb_Pieces_Alignees) then
	       return True;
	    elsif (E(J)(I) = Symbole_Joueur) then
	       Voisins_Colonne := Voisins_Colonne + 1;
	    else
	       Voisins_Colonne := 0;
	    end if;
	 end loop;
      end loop;
      
      --  Boucle de recherche par ligne
      for I in Integer range 1..Hauteur loop
	 for J in Integer range 1..Largeur loop
	    if (Voisins_Ligne = Nb_Pieces_Alignees) then
	       return True;
	    elsif (E(J)(I) = Symbole_Joueur) then
	       Voisins_Ligne := Voisins_Ligne + 1;
	    else
	       Voisins_Ligne := 0;
	    end if;
	 end loop;
      end loop;
	 
      --  Boucle de recherche par diagonale NE-SO
      for I in Integer range Largeur..1 loop
	 Colonne_Diagonale := I;
	 Ligne_Diagonale := 1;
	 while (Ligne_Diagonale <= Largeur) loop
	    if (Voisins_Diagonale = Nb_Pieces_Alignees) then
	       return True;
	    elsif (E(Colonne_Diagonale)(Ligne_Diagonale) = Symbole_Joueur) then
	       Voisins_Diagonale := Voisins_Diagonale + 1;
	    else
	       Voisins_Diagonale := 0;
	    end if;
	    
	    Colonne_Diagonale := Colonne_Diagonale + 1;
	    Ligne_Diagonale := Ligne_Diagonale + 1;
	 end loop;
      end loop;      
      
      return False;
   end Est_Gagnant;
   
   
   function Est_Nul(E :Etat) return Boolean is      
   begin
      if (Est_Gagnant(E,Joueur1)) then
	 return False;
      elsif (Est_Gagnant(E,Joueur2)) then
	 return False;
      else
	 for I in E'Range loop
	    if (E(I)(Hauteur) = ' ') then
	       return False;
	    end if;
	 end loop;
	 return True;
      end if;
   end Est_Nul;
   
   
   procedure Afficher(E :Etat) is
   begin
      Put_Line("---------------------------------------------------------------------------");
      
      for I in Integer range 1..Largeur loop
	 Put(" " & Integer'Image(I));
      end loop;
      Put_Line("");
      
      for I in Integer range 1 .. Hauteur loop
	 Put("| ");
	 for J in Integer range 1..Largeur loop
	    Put(E(J)(Hauteur-I+1) & "| ");
	 end loop;
	 Put_Line("");
      end loop;
      Put_Line("------------");	    
   end Afficher;
   
   procedure Affiche_Coup(C : in Coup) is
   begin
      if (C.Symbole = 'X') then
	 Put_Line("Joueur 1 joue : " & Integer'Image(C.Indice_Colonne));
      else
	 Put_Line("Joueur 2 joue : " & Integer'Image(C.Indice_Colonne));
      end if;
   end Affiche_Coup;
   
   
   
   function Recherche_Case_Libre(E :Etat; Indice_Colonne : Integer) return Integer is
   begin
      --  On renvoit 0 si on n'a trouvé aucune case libre
      for I in 1..Hauteur loop
	 if (E(Indice_Colonne)(I) = ' ') then	    
	    return I;
	 end if;
      end loop;
      return 0;      
   end Recherche_Case_Libre;

end Puissance4;
