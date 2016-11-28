with Participant;
use Participant;

generic
   
   Hauteur : Integer;
   Largeur : Integer;
   Nb_Pieces_Alignees : Integer;
   
package Puissance4 is
   
   type Etat is private;
   type Coup is private;   
   
   procedure Initialiser (E : in out Etat);   
   
   -- Calcule l'etat suivant en appliquant le coup
   function Etat_Suivant(E : Etat; C : Coup) return Etat;    
    
   -- Indique si l'etat courant est gagnant pour le joueur J
   function Est_Gagnant(E : Etat; J : Joueur) return Boolean; 

   -- Indique si l'etat courant est un status quo (match nul)
   function Est_Nul(E : Etat) return Boolean; 
   
   -- Fonction d'affichage de l'etat courant du jeu
   procedure Affiche_Jeu(E : Etat);
   
   -- Affiche a l'ecran le coup passe en parametre
   procedure Affiche_Coup(C : in Coup);   
   
   -- Retourne le prochaine coup joue par le joueur1
   function Demande_Coup_Joueur1(E : Etat) return Coup;
   
   -- Retourne le prochaine coup joue par le joueur2   
   function Demande_Coup_Joueur2(E : Etat) return Coup;   

private
   
   type Colonne is array (1..Hauteur) of Character;
   type Matrice is array (1..Largeur) of Colonne;   
   
   type Etat is record
      
   end record;
   
   type Coup is record
      Colonne : Integer;      
   end record;
   
end Puissance4;
