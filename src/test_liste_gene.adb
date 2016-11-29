with Ada.Text_Io; use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_Io;
with Ada.Unchecked_Deallocation;

with liste_generique;

procedure Test_Liste_Gene is
   -- procedure d'affiche
   procedure Affiche_Integer(I : in Integer) is
   begin
      Put(Integer'Image(I));
   end;
   
   --  instanciation avec des entiers
   package List_Int is new liste_generique(Integer,Affiche_Integer);
   use List_Int;
   
   --Déclarations
   L : Liste;
   It : Iterateur;
   Val : Integer;
begin
   L := Creer_Liste;
   Insere_Tete(5,L);
   Insere_Tete(4,L);
   Insere_Tete(3,L);
   Insere_Tete(2,L);
   Insere_Tete(1,L);
   Affiche_Liste(L);

   New_Line;
   Put_Line("test affichage avec l'IT :");
   It := Creer_Iterateur(L);
   loop
      Val := Element_Courant(It);
      Put_Line(Integer'Image(Val));
      exit when not A_Suivant(It);
      Suivant(It);
   end loop;
   
   Libere_Liste(L);
end Test_Liste_Gene;
