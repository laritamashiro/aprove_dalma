// ============================================================
// CONFIGURAÇÃO — projeto Supabase "Aprove D'Alma"
// ============================================================
const SUPABASE_URL = "https://wotzelzsmhtyebmsobxp.supabase.co";
const SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndvdHplbHpzbWh0eWVibXNvYnhwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODgzNzc2MDAsImV4cCI6MjEwMzk1MzYwMH0.jOKyDHjxYlXXq49ejJ8FoUfcu3het-xsAu2p88sQK3k";

const supabaseClient = supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY);
const BUCKET = "criativos";
