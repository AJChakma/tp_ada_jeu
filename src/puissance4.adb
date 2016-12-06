with Ada.Text_IO, Ada.Integer_Text_IO, Participant;
use Ada.Text_IO, Ada.Integer_Text_IO, Participant;

package body Puissance4 is
   
   use Liste_Coups;
   
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
	or else Est_Gagnant_Diagonale_SO_NE(E,Symbole_Joueur)
	or else Est_Gagnant_Diagonale_SE_NO(E,Symbole_Joueur);
   end Est_Gagnant;
   
   
   function Est_Gagnant_Colonne(E :Etat; Sym_Joueur : Character) return Boolean is
      Voisins_Colonne : Integer;            
   begin
      
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
   
   
   function Est_Gagnant_Diagonale_SO_NE(E :Etat; Sym_Joueur : Character) return Boolean is
      Voisins_Diagonale : Integer;            
      Ligne_Diagonale : Integer;
      Colonne_Diagonale : Integer;   
   begin
	 

      for J in reverse 1..Largeur loop
	 Colonne_Diagonale := J;
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
   end Est_Gagnant_Diagonale_SO_NE;
   
   
   function Est_Gagnant_Diagonale_SE_NO(E :Etat; Sym_Joueur : Character) return Boolean is
      Voisins_Diagonale : Integer;            
      Ligne_Diagonale : Integer;
      Colonne_Diagonale : Integer;   
   begin
      
    
      for J in Integer range 1..Largeur loop
	 Colonne_Diagonale := J;
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
   end Est_Gagnant_Diagonale_SE_NO;

     
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
   
   
   procedure Affiche_Integer(I : in Integer) is
   begin
      Put(Integer'Image(I));
   end Affiche_Integer;
      
   function Eval_Colonnes(E :Etat; Sym_Joueur : Character) return Integer is
      Eval : Integer := 0;
   begin
      for J in Integer range 1..Largeur loop
	 Eval := Eval + Eval_Colonne(J,E,Sym_Joueur);
      end loop;
      return Eval;
   end Eval_Colonnes;

   function Eval_Colonne(Col : Integer; E : Etat; Sym_Joueur : Character) return Integer is
      Nb_Symboles : Integer := 0;
   begin
      for I in Integer range 1..Hauteur loop
	 if (E(Col)(I) = Sym_Joueur) then
	    Nb_Symboles := Nb_Symboles + 1;
	 elsif (E(Col)(I) = ' ') then
	    return Nb_Symboles*Facteur_Eval/Nb_Pieces_Alignees;
	 else
	    Nb_Symboles := 0;
	 end if;
      end loop;
      return Nb_Symboles*Facteur_Eval/Nb_Pieces_Alignees;
   end Eval_Colonne;
   
   
   function Eval_Lignes(E :Etat; Sym_Joueur : Character) return Integer is
      Eval : Integer := 0;
   begin
      for I in Integer range 1..Hauteur loop
	 Eval := Eval + Eval_Ligne(I,E,Sym_Joueur);
      end loop;
      return Eval;
   end Eval_Lignes;

   function Eval_Ligne(Lig : Integer; E : Etat; Sym_Joueur : Character) return Integer is
      Nb_Symboles : Integer := 0;
      Nb_Espaces_Vides : Integer := 0;
   begin
      for J in Integer range 1..Largeur loop
	 --  On compte les symboles et les espaces vides entre les symboles
	 if (E(J)(Lig) = Sym_Joueur or else E(J)(Lig) = ' ') then
	    if (E(J)(Lig) = ' ') then
	       Nb_Espaces_Vides := Nb_Espaces_Vides + 1;
	    end if;
	    Nb_Symboles := Nb_Symboles + 1;
	 else
	    Nb_Symboles := 0;
	    Nb_Espaces_Vides := 0;
	 end if;
      end loop;
      return (Nb_Symboles*Facteur_Eval-Nb_Espaces_Vides*Facteur_Eval)/Nb_Pieces_Alignees;
   end Eval_Ligne;
         
   
   function Eval_Diagonale_SE_NO(E : Etat; Sym_Joueur : Character) return Integer is
      Nb_Symboles : Integer := 0;
      Ligne_Diagonale : Integer;
      Colonne_Diagonale : Integer;
   begin
      for J in Integer range 1..Largeur loop
	 Colonne_Diagonale := J;
	 Ligne_Diagonale := 1;
	 Nb_Symboles := 0;
	 while (Colonne_Diagonale >= 1) loop	    
	    if (E(Colonne_Diagonale)(Ligne_Diagonale) = Sym_Joueur or else E(Colonne_Diagonale)(Ligne_Diagonale) = ' ') then
	       Nb_Symboles := Nb_Symboles + 1;
	    else
	       Nb_Symboles := 0;
	    end if;	    
	    Colonne_Diagonale := Colonne_Diagonale - 1;
	    Ligne_Diagonale := Ligne_Diagonale + 1;
	 end loop;
      end loop;            
      return Nb_Symboles*Facteur_Eval/Nb_Pieces_Alignees;
   end Eval_Diagonale_SE_NO;
   
   
   function Eval_Diagonale_SO_NE(E : Etat; Sym_Joueur : Character) return Integer is
      Nb_Symboles : Integer := 0;
      Ligne_Diagonale : Integer;
      Colonne_Diagonale : Integer;
   begin    
      for J in reverse 1..Largeur loop
	 Colonne_Diagonale := J;
	 Ligne_Diagonale := 1;
	 Nb_Symboles := 0;
	 while (Colonne_Diagonale <= Largeur) loop	    
	    if (E(Colonne_Diagonale)(Ligne_Diagonale) = Sym_Joueur or else E(Colonne_Diagonale)(Ligne_Diagonale) = ' ') then
	       Nb_Symboles := Nb_Symboles + 1;
	    else
	       Nb_Symboles := 0;
	    end if;	    
	    Colonne_Diagonale := Colonne_Diagonale + 1;
	    Ligne_Diagonale := Ligne_Diagonale + 1;
	 end loop;
      end loop;            
      return Nb_Symboles*Facteur_Eval/Nb_Pieces_Alignees;
   end Eval_Diagonale_SO_NE;
   
   function Eval(E : Etat; J : Joueur) return Integer is
      Sym_Joueur : Character;
   begin
      if (J = Joueur1) then
	 Sym_Joueur := 'X';
      else
	 Sym_Joueur := 'O';
      end if;
      
      return Eval_Lignes(E,Sym_Joueur) + Eval_Colonnes(E,Sym_Joueur) + Eval_Diagonale_SO_NE(E,Sym_Joueur) + Eval_Diagonale_SE_NO(E,Sym_Joueur);

   end Eval;
   
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
   
   
   function Coups_Possibles(E : Etat; J : Joueur) return Liste_Coups.Liste is
      L_Coups_Possibles : Liste := Creer_Liste;
      Coup_Possible : Coup;
   begin
      for I in Integer range 1..Largeur loop
	 if (Recherche_Case_Libre(E,I) /= 0) then
	    if (J = Joueur1) then
	       Coup_Possible.Symbole := 'X';
	    else
	       Coup_Possible.Symbole := 'O';
	    end if;
	    Coup_Possible.Indice_Colonne := I;
	    Insere_Tete(Coup_Possible,L_Coups_Possibles);
	 end if;
      end loop;
      return L_Coups_Possibles;
   end Coups_Possibles;
   
   function Compte_Nb_Symbole(E :Etat; Symbole_A_Compter : Character) return Integer is
      Nb_Symbole : Integer := 0;
   begin
      for J in Integer range 1..Largeur loop
	 for I in Integer range 1..Hauteur loop
	    if (E(J)(I) = Symbole_A_Compter) then
	       Nb_Symbole := Nb_Symbole + 1;
	    end if;
	 end loop;
      end loop;
      return Nb_Symbole;
   end Compte_Nb_Symbole;
   
   
end Puissance4;
