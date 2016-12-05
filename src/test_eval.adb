with Ada.Text_Io, Ada.Integer_Text_Io; 
use Ada.Text_Io, Ada.Integer_Text_Io;
with Participant; use Participant;
with Liste_Generique;
with Moteur_Jeu;
with Puissance4;
with Partie;

procedure Test_Eval is
   
   --  type Coup is record
   --     Indice_Colonne : Integer;
   --     Symbole : Character;
   --  end record;
   
      
   --  procedure Affiche_Coup(C : in Coup) is
   --  begin
   --     if (C.Symbole = 'X') then
   --  	 Put_Line("Joueur 1 joue : " & Integer'Image(C.Indice_Colonne));
   --     else
   --  	 Put_Line("Joueur 2 joue : " & Integer'Image(C.Indice_Colonne));
   --     end if;
   --  end Affiche_Coup;
   
   --  package Liste_Coups is new Liste_Generique(Coup,Affiche_Coup);
   --  use Liste_Coups;
   
   
   package MyPuissance4 is new Puissance4(5,5,5);   
   use MyPuissance4;
   
   package Liste_Coups is new Liste_Generique(Coup,Affiche_Coup);
   use Liste_Coups;
   

   
   package MyMoteurJeu is new Moteur_Jeu(MyPuissance4.Etat,
					 MyPuissance4.Coup,
					 MyPuissance4.Jouer,
					 MyPuissance4.Est_Gagnant,
					 MyPuissance4.Est_Nul,
					 MyPuissance4.Affiche_Coup,
					 MyPuissance4.Liste_Coups,
					 MyPuissance4.Coups_Possibles,
					 MyPuissance4.Eval,
					 2,
					 Joueur1);
   use MyMoteurJeu;
   
   package MyPartie is new Partie(MyPuissance4.Etat,
				  MyPuissance4.Coup,
				  "Machine",
				  "Bob",
				  MyPuissance4.Jouer,
				  MyPuissance4.Est_Gagnant,
				  MyPuissance4.Est_Nul,
				  MyPuissance4.Afficher,
				  MyPuissance4.Affiche_Coup,
				  MyMoteurJeu.Choix_Coup,
				  MyPuissance4.Demande_Coup_Joueur2);
   E : Etat;
begin
   Initialiser(E);
   
   MyPartie.Joue_Partie(E,Joueur1);   
   
end Test_Eval;
