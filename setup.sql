-- ============================================================
-- SETUP DO BANCO — Sistema de Aprovação de Criativos
-- Cole este script inteiro no SQL Editor do seu projeto Supabase
-- (Supabase → seu projeto → SQL Editor → New query → colar → Run)
-- ============================================================

-- Tabela principal: cada linha é um criativo enviado pra aprovação
create table if not exists creativos (
  id uuid primary key default gen_random_uuid(),
  cliente_nome text not null,
  post_nome text not null,
  data_prevista date,
  legenda text,
  arquivo_url text not null,
  arquivo_tipo text not null default 'image', -- 'image' ou 'video'
  status text not null default 'pendente',    -- 'pendente' | 'aprovado' | 'ajuste'
  comentario_cliente text,
  criado_em timestamptz not null default now(),
  respondido_em timestamptz
);

-- Habilita Row Level Security (obrigatório no Supabase)
alter table creativos enable row level security;

-- Como não há login (link oculto), liberamos leitura, criação e
-- atualização de status pra chave anônima. A segurança aqui é o
-- link em si ser imprevisível (UUID), não uma senha.
create policy "permitir leitura" on creativos
  for select using (true);

create policy "permitir insercao" on creativos
  for insert with check (true);

create policy "permitir atualizacao de status" on creativos
  for update using (true);

-- ============================================================
-- STORAGE — bucket público para os arquivos dos criativos
-- ============================================================
-- Vá em Storage → Create bucket → nome: "criativos" → marque "Public bucket"
-- Depois rode o bloco abaixo pra liberar upload público:

insert into storage.buckets (id, name, public)
values ('criativos', 'criativos', true)
on conflict (id) do nothing;

create policy "upload publico criativos" on storage.objects
  for insert with check (bucket_id = 'criativos');

create policy "leitura publica criativos" on storage.objects
  for select using (bucket_id = 'criativos');
