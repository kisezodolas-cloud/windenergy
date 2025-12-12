DROP TABLE IF EXISTS public.eoliennes;
DROP TABLE IF EXISTS public.utilisateurs;
DROP VIEW IF EXISTS public.eoliennes_view;

-- CREE LA TABLE utilisateurs
CREATE TABLE IF NOT EXISTS public.utilisateurs (
  id uuid PRIMARY KEY REFERENCES auth.users(id),
  email TEXT,
  nom TEXT,
  prenom TEXT
);

-- CREE la table eoliennes
CREATE TABLE IF NOT EXISTS public.eoliennes(
  numero_serie CHAR(8) PRIMARY KEY,
  utilisateur_id uuid REFERENCES public.utilisateurs(id) ON DELETE CASCADE,
  orientation float default 0,
  vitesse_rotation float default 0,
  puissance_genere float default 0,
  temp_derniere_mesure timestamp default now()
);

-- CREE une vue eolienne_view qui va intégrer le champ actif et hash_securité
CREATE OR REPLACE VIEW eoliennes_view as
  SELECT numero_serie,utilisateur_id,orientation,vitesse_rotation,
  puissance_genere,temp_derniere_mesure,
  hashtext(CONCAT(utilisateur_id,numero_serie)) as hash_securite,
  (EXTRACT(EPOCH FROM (now() - temp_derniere_mesure)) > 10) AS actif
  FROM public.eoliennes;

DROP VIEW IF EXISTS public.eoliennes_view;
DROP TABLE IF EXISTS public.eoliennes;
DROP TABLE IF EXISTS public.utilisateurs;


-- CREE LA TABLE utilisateurs
CREATE TABLE IF NOT EXISTS public.utilisateurs (
  id uuid PRIMARY KEY REFERENCES auth.users(id),
  email TEXT,
  nom TEXT,
  prenom TEXT
);

-- CREE la table eoliennes
CREATE TABLE IF NOT EXISTS public.eoliennes(
  numero_serie CHAR(8) PRIMARY KEY,
  utilisateur_id uuid REFERENCES public.utilisateurs(id) ON DELETE CASCADE,
  orientation float default 0,
  vitesse_rotation float default 0,
  puissance_genere float default 0,
  temp_derniere_mesure timestamp default now()
);

-- CREE une vue eolienne_view qui va intégrer le champ actif et hash_securité
CREATE OR REPLACE VIEW eoliennes_view as
  SELECT numero_serie,utilisateur_id,orientation,vitesse_rotation,
  puissance_genere,temp_derniere_mesure,
  hashtext(CONCAT(utilisateur_id,numero_serie)) as hash_securite,
  (EXTRACT(EPOCH FROM (now() - temp_derniere_mesure)) > 10) AS actif
  FROM public.eoliennes;


-- inserts a row into public.utilisateurs
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = ''
as $$
begin
  insert into public.utilistateurs(id,email,nom,prenom)
  values (new.id,new.email,new.raw_user_meta_data->>'nom',new.raw_user_meta_data->>'prenom'); -- new.raw_user_meta_data permet de récupérer les informations envoyé dans les métadonnées (data en flutter)
  return new;
end;
$$;

-- trigger the function every time a user is created
create or replace trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
