with Ada.Text_IO, Ada.Integer_Text_IO, Participant;
use Ada.Text_IO, Ada.Integer_Text_IO, Participant;

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
      Coup_Joue : Coup := C;
      Etat_Res : Etat := E;
      Ligne_Case_Libre : Integer := Recherche_Case_Libre(E,Coup_Joue.Indice_Colonne);
   begin      
      --  On vérifie que la colonne demandée est correcte
      while Ligne_Case_Libre <= 0 loop
	 if Ligne_Case_Libre = 0 then
	    Put_Line("La colonne est pleine, veuillez en choisir une autre !");
	 elsif Ligne_Case_Libre = -1 then
	    Put_Line("La colonne est en dehors du jeu, veuillez en choisir une autre !");
	 end if;
	 if (Coup_Joue.Symbole = 'X') then
	    Coup_Joue := Demande_Coup_Joueur1(E);
	 else
	    Coup_Joue := Demande_Coup_Joueur2(E);
	 end if;
      Ligne_Case_Libre := Recherche_Case_Libre(E,Coup_Joue.Indice_Colonne);	 
      end loop;
      
      Etat_Res(Coup_Joue.Indice_Colonne)(Ligne_Case_Libre) := Coup_Joue.Symbole;
      
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
      Symbole_Joueur : Character;      
   begin
      if (J = Joueur1) then
	 Symbole_Joueur := 'X';
      else
	 Symbole_Joueur := 'O';
      end if;
      
      return Est_Gagnant_Colonne(E,Symbole_Joueur) 
	or else Est_Gagnant_Ligne(E,Symbole_Joueur) 
	or else Est_Gagnant_Diagonale_NE_SO(E,Symbole_Joueur)
	or else Est_Gagnant_Diagonale_NO_SE(E,Symbole_Joueur);
   end Est_Gagnant;
   
   
   function Est_Gagnant_Colonne(E :Etat; Sym_Joueur : Character) return Boolean is
      Voisins_Colonne : Integer;            
   begin
      
      --  Boucle de recherche par colonne
      for J in Integer range 1..Largeur loop
	 Voisins_Colonne := 0;
	 for I in Integer range 1..Hauteur loop
	    if (E(J)(I) = Sym_Joueur) then
	       Voisins_Colonne := Voisins_Colonne + 1;
	       if (Voisins_Colonne = Nb_Pieces_Alignees) then
		  return True;
	       end if;
	    else
	       Voisins_Colonne := 0;
	    end if;
	 end loop;
      end loop;
      
      return False;
   end Est_Gagnant_Colonne;   
   
   
   function Est_Gagnant_Ligne(E :Etat; Sym_Joueur : Character) return Boolean is
      Voisins_Ligne : Integer;            
   begin
      
      --  Boucle de recherche par ligne
      for I in Integer range 1..Hauteur loop
	 Voisins_Ligne := 0;
	 for J in Integer range 1..Largeur loop	    
	    if (E(J)(I) = Sym_Joueur) then
	       Voisins_Ligne := Voisins_Ligne + 1;
	       if (Voisins_Ligne = Nb_Pieces_Alignees) then
		  return True;
	       end if;
	    else
	       Voisins_Ligne := 0;
	    end if;
	 end loop;
      end loop;
      
      return False;
   end Est_Gagnant_Ligne;
   
   
   function Est_Gagnant_Diagonale_NE_SO(E :Etat; Sym_Joueur : Character) return Boolean is
      Voisins_Diagonale : Integer;            
      Ligne_Diagonale : Integer;
      Colonne_Diagonale : Integer;   
   begin
	 
      --  Boucle de recherche par diagonale NE-SO
      for I in reverse 1..Largeur loop
	 Colonne_Diagonale := I;
	 Ligne_Diagonale := 1;
	 Voisins_Diagonale := 0;
	 while (Colonne_Diagonale <= Largeur) loop
	    if (E(Colonne_Diagonale)(Ligne_Diagonale) = Sym_Joueur) then
	       Voisins_Diagonale := Voisins_Diagonale + 1;
	       if (Voisins_Diagonale = Nb_Pieces_Alignees) then
		  return True;
	       end if;
	    else
	       Voisins_Diagonale := 0;
	    end if;
	    
	    Colonne_Diagonale := Colonne_Diagonale + 1;
	    Ligne_Diagonale := Ligne_Diagonale + 1;
	 end loop;
      end loop;      
      
      return False;
   end Est_Gagnant_Diagonale_NE_SO;
   
   
   function Est_Gagnant_Diagonale_NO_SE(E :Etat; Sym_Joueur : Character) return Boolean is
      Voisins_Diagonale : Integer;            
      Ligne_Diagonale : Integer;
      Colonne_Diagonale : Integer;   
   begin
      
      --  Boucle de recherche par diagonale NE-SO
      for I in Integer range 1..Largeur loop
	 Colonne_Diagonale := I;
	 Ligne_Diagonale := 1;
	 Voisins_Diagonale := 0;
	 while (Colonne_Diagonale >= 1) loop	    
	    if (E(Colonne_Diagonale)(Ligne_Diagonale) = Sym_Joueur) then
	       Voisins_Diagonale := Voisins_Diagonale + 1;
	       if (Voisins_Diagonale = Nb_Pieces_Alignees) then
		  return True;
	       end if;
	    else
	       Voisins_Diagonale := 0;
	    end if;
	    
	    Colonne_Diagonale := Colonne_Diagonale - 1;
	    Ligne_Diagonale := Ligne_Diagonale + 1;
	 end loop;
      end loop;      
      
      return False;
   end Est_Gagnant_Diagonale_NO_SE;

   
      
   
   
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
      
      --  Affichage de l'indice de chaque colonne
      for I in Integer range 1..Largeur loop
	 Put(" " & Integer'Image(I));
      end loop;
      Put_Line("");
      
      --  Affichage du contenu de chaque colonne (symboles X ou O)
      for I in reverse 1 .. Hauteur loop
	 Put("| ");
	 for J in Integer range 1..Largeur loop
	    Put(E(J)(I) & "| ");
	 end loop;
	 Put_Line("");
      end loop;            
      
      --  Affichage du bas de la matrice
      for I in Integer range 1..Largeur loop
	 Put("---");
      end loop;
      Put("-");
      Put_Line("");

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
      --  On renvoie -1 si l'indice de colonne n'est pas dans le range de la matrice d'état
      if Indice_Colonne < 0 or else Indice_Colonne > Largeur then
	 return -1;
      end if;
	--  On renvoie l'indice de la case libre trouvée
      for I in 1..Hauteur loop
	 if (E(Indice_Colonne)(I) = ' ') then	    
	    return I;
	 end if;
      end loop;
      
      --  On renvoie 0 si on n'a trouvé aucune case libre
      return 0;      
   end Recherche_Case_Libre;

end Puissance4;
