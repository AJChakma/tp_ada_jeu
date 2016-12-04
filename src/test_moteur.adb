with Ada.Text_Io, Ada.Integer_Text_Io; 
use Ada.Text_Io, Ada.Integer_Text_Io;
with Participant; use Participant;
with Liste_Generique;
with Moteur_Jeu;

procedure Test_Moteur is
   
   function Coup_Suivant(E : Integer; C : Integer) return Integer is
   begin
	 return E+C;
   end Coup_Suivant;
   
   -- Indique si l'etat courant est gagnant pour J
   function Est_Gagnant(E : Integer; J : Joueur) return Boolean is
   begin
      if E = 21 then
	 return True;
      else
	 return False;
      end if;
   end Est_Gagnant;  
   
   -- Indique si l'etat courant est un status quo (match nul)
   function Est_Nul(E : Integer) return Boolean is
   begin
      if E>21 then
	 return True;
      else
	 return False;
      end if;
   end Est_Nul;
   
   -- Affiche a l'ecran le coup passe en parametre
   procedure Affiche_Coup(C : in Integer) is
   begin
      Put(Integer'Image(C));
   end Affiche_Coup;
   
   function Eval(E : Integer) return Integer is
   begin
      if E = 21 then
	 return Integer'Last;
      elsif E > 21 then
	 return 0;
      elsif E = 17 then
	 return -100;
      elsif E >= 18 and E <= 20 then
	 return 50;	--  entre 18 et 20 on est bien
      else
	 return 0;
      end if;
   end Eval;
   
   package Liste_Coups is new Liste_Generique(Integer,Affiche_Coup);
   use Liste_Coups;
   -- Retourne la liste des coups possibles pour J a partir de l'etat 
   function Coups_Possibles(E : Integer; J : Joueur) return Liste_Coups.Liste is 
      L : Liste_Coups.Liste;
   begin	    
      L := Creer_Liste;
      Insere_Tete(1,L);
      Insere_Tete(2,L);
      Insere_Tete(3,L);
      return L;
   end Coups_Possibles;

   package Moteur_Jeu_Test is new Moteur_Jeu(Integer,Integer,
					     Coup_Suivant,
					     Est_Gagnant,
					     Est_Nul,
					     Affiche_Coup,
					     Liste_Coups,
					     Coups_Possibles,
					     Eval,2,Joueur1);
   use Moteur_Jeu_Test;
   Score : Integer := 16;
   CoupIA,CoupJoueur : Integer;
begin
   Put("début de partie score : " & Integer'Image(Score));
   New_Line;
   loop
      Put_Line("à l'ordinateur de jouer");
      CoupIA := Choix_Coup(Score);
      New_Line;
      New_Line;
      Put("l'ordiateur joue ");
      Affiche_Coup(CoupIA);
      New_Line;
      Score := Coup_Suivant(Score,CoupIA);
      Put("Nouveau score : " & Integer'Image(Score));
      New_Line;
      exit when Est_Gagnant(Score,Joueur1) or Est_Nul(Score);
      Put("à vous de jouer ");
      Get(CoupJoueur);
      Score := Coup_Suivant(Score,CoupJoueur);
      Put("Nouveau score : " & Integer'Image(Score));
      New_Line;
      exit when Est_Gagnant(Score,Joueur2) or Est_Nul(Score);
   end loop;
   Put("Partie terminée.");

end Test_Moteur;

