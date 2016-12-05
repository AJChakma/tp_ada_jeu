with Participant;
use Participant;
with Liste_Generique;

generic
   
   Hauteur : Integer;
   Largeur : Integer;
   Nb_Pieces_Alignees : Integer;
   
   with package Liste_Coups is new Liste_Generique(Coup,Affiche_Coup);
   use Liste_Coups;   
             
package Puissance4 is
   
   type Etat is private;
   type Coup is private;      
   
   -- Affiche a l'ecran le coup passe en parametre
   procedure Affiche_Coup(C : in Coup);   
   
   procedure Initialiser(E : in out Etat);   
   
   -- Calcule l'etat suivant en appliquant le coup
   function Jouer(E : Etat; C : Coup) return Etat;    
    
   -- Indique si l'etat courant est gagnant pour le joueur J
   function Est_Gagnant(E : Etat; J : Joueur) return Boolean; 
   
   -- Indique si l'etat courant est un status quo (match nul)
   function Est_Nul(E : Etat) return Boolean; 
   
   -- Fonction d'affichage de l'etat courant du jeu
   procedure Afficher(E : Etat);
   

   -- Retourne le prochaine coup joue par le joueur1
   function Demande_Coup_Joueur1(E : Etat) return Coup;
   
   -- Retourne le prochaine coup joue par le joueur2   
   function Demande_Coup_Joueur2(E : Etat) return Coup;   
   
   --  Evaluation statique d'un état 
   --function Eval(E : Etat; J : Joueur) return Integer;   
   ------------------------------------------------------
   --ERREUR !! La Eval est indépendante du joueur, ne prend
   --que l'état en paramètre !!
   ------------------------------------------------------
   function Eval(E : Etat) return Integer;
   
   -- Retourne la liste des coups possibles pour J a partir de l'etat 
   function Coups_Possibles(E : Etat; J : Joueur) return Liste_Coups.Liste;    

private   
   
   Facteur_Eval : constant Integer := 100;
   
   procedure Affiche_Integer(I : in Integer);   
   
   package Liste_Integer is new Liste_Generique(Integer,Affiche_Integer);
   
   type Colonne is array (1..Hauteur) of Character;
   type Etat is array (1..Largeur) of Colonne;   
      
   type Coup is record
      Indice_Colonne : Integer;
      Symbole : Character;
   end record;
   

   function Recherche_Case_Libre(E : Etat; Indice_Colonne : Integer) return Integer;
   
   function Est_Gagnant_Colonne(E :Etat; Sym_Joueur : Character) return Boolean;
   
   function Est_Gagnant_Ligne(E :Etat; Sym_Joueur : Character) return Boolean;
   
   function Est_Gagnant_Diagonale_SO_NE(E :Etat; Sym_Joueur : Character) return Boolean;
   
   function Est_Gagnant_Diagonale_SE_NO(E :Etat; Sym_Joueur : Character) return Boolean;
   
   function Eval_Diagonale_SO_NE(E : Etat; Sym_Joueur : Character) return Integer;
   
   function Eval_Diagonale_SE_NO(E : Etat; Sym_Joueur : Character) return Integer;
   
   function Eval_Lignes(E :Etat; Sym_Joueur : Character) return Integer;
      
   function Eval_Ligne(Lig : Integer; Sym_Joueur : Character) return Integer;
   
   function Eval_Colonnes(E :Etat; Sym_Joueur : Character) return Integer;
   
   function Eval_Colonne(Col : Integer; Sym_Joueur : Character) return Integer;
   
end Puissance4;
