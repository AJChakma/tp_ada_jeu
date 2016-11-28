--  Fichier d'implémentation des méthodes génériques
--  du package Liste_Generique
with Ada.Unchecked_Deallocation;

package body Liste_Generique is
   
   --  instanciation de la méthode de libération.
   procedure Libere is new Ada.Unchecked_Deallocation (Cellule, Liste);
   procedure LibereIt is new Ada.Unchecked_Deallocation (Iterateur_Interne,Iterateur);
    -- Affichage de la liste, dans l'ordre de parcours
   procedure Affiche_Liste (L : in Liste) is
      EleCourant : Liste := L;
   begin
      while EleCourant /= null loop
	 Put(EleCourant.Ele);
	 Put(" ");			--  Affiche un espace entre chaque élement
	 EleCourant := EleCourant.Next;
      end loop;
   end Affiche_Liste;

    -- Insertion d'un element V en tete de liste
   procedure Insere_Tete (V : in Element; L : in out Liste) is 
   begin
      L := new Cellule'(V, L);
   end Insere_Tete;

    -- Vide la liste et libere toute la memoire utilisee
   procedure Libere_Liste(L : in out Liste) is 
      Tmp : Liste;
     begin
	while L /= null loop
	   Tmp := L;
	   L := L.Next;
	   Libere(Tmp);
	end loop;
     end Libere_Liste;

    -- Creation de la liste vide
     function Creer_Liste return Liste is 
     begin
	return null;
     end Creer_Liste;

    -- Cree un nouvel iterateur 
     function Creer_Iterateur (L : Liste) return Iterateur is 
	--  L'itérateur est en fait une "copie" de la liste elle même, un sorte de gros tampon
	It : Iterateur := L;
     begin
	return It;
     end Creer_Iterateur;

    -- Liberation d'un iterateur
     procedure Libere_Iterateur(It : in out Iterateur) is 	
     begin
	--  On fait simplement dépointer l'itérateur
	It.Next := null;		--  par sécuritée
	LibereIt(It);
     end Libere_Iterateur;

    -- Avance d'une case dans la liste
     procedure Suivant(It : in out Iterateur) is 
     begin
	if A_Suivant(It) then
	   It := It.Next;
	else
	   raise FinDeListe;
	end if;
     end Suivant;

    -- Retourne l'element courant
     function Element_Courant(It : Iterateur) return Element is 
     begin
	return It.Ele;
     end Element_Courant;

    -- Verifie s'il reste un element a parcourir
     function A_Suivant(It : Iterateur) return Boolean is 
     begin
	return (It.Next /= null);
     end A_Suivant;
   
end Liste_Generique;
