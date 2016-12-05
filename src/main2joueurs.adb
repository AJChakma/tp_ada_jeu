with Ada.Text_IO; 
with Ada.Integer_Text_IO;
with Puissance4;
with Participant;
with Partie;
with Liste_Generique;
with Moteur_Jeu;

use Ada.Text_IO;
use Ada.Integer_Text_IO;
use Participant;

procedure Main2Joueurs is
   
   package MyPuissance4 is new Puissance4(4,4,4);
   
   --INSTANCIATIONS POUR JOUER CONTRE L'IA
   --------------------------------------------------------------------------------
   
   -- Instanciation d'une liste de coups qui seront les coups possibles
   package Liste_Coups is new Liste_Generique(MyPuissance4.Coup,
					      MyPuissance4.Affiche_Coup);
   use Liste_Coups;
   
   --  Retourne une listes de coups possibles pour le joueur J
   function Coups_Possibles(E : MyPuissance4.Etat; J : Joueur) return Liste is
      L : Liste;
   begin
     return L;				--  à compléter
   end Coups_Possibles;
   
   --  Fonction d'évaluation statique de l'état
   function Eval(E: MyPuissance4.Etat) return Integer is
      Res : Integer;
   begin
      return Res;			--  à compléter
   end Eval;
   
   --  définition d'une IA joueur1 pour adverssaire avec le moteur de jeu
      package IA_Player is new Moteur_Jeu(MyPuissance4.Etat,
					  MyPuissance4.Coup,
					  MyPuissance4.Jouer,
					  MyPuissance4.Est_Gagnant,
					  MyPuissance4.Est_Nul,
					  MyPuissance4.Affiche_Coup,
					  Liste_Coups,
					  Coups_Possibles,
					  Eval
					  ,3 --  Profondeur
					    ,Joueur1);
      
      use IA_Player;
      
      --------------------------------------------------------------------------------
      
   -- definition d'une partie entre un humain en Joueur 1 et un humain en Joueur 2
   package MyPartie is new Partie(MyPuissance4.Etat,
				  MyPuissance4.Coup, 
				  "Pierre",
				  "Paul",
				  MyPuissance4.Jouer,
				  MyPuissance4.Est_Gagnant,
				  MyPuissance4.Est_Nul,
				  MyPuissance4.Afficher,
				  MyPuissance4.Affiche_Coup,
				  MyPuissance4.Demande_Coup_Joueur1,
				  MyPuissance4.Demande_Coup_Joueur2);
   use MyPartie;
   
   P: MyPuissance4.Etat;

begin
   Put_Line("Puissance 4");
   Put_Line("");
   Put_Line("Joueur 1 : X"); 
   Put_Line("Joueur 2 : O");
   
   MyPuissance4.Initialiser(P);
   
   Joue_Partie(P, Joueur2);
end Main2Joueurs;
