-- Projects table
CREATE TABLE projects (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  codename TEXT NOT NULL,
  tagline TEXT DEFAULT '',
  tech_stack TEXT[] DEFAULT '{}',
  status TEXT DEFAULT 'ACTIVE',
  severity TEXT DEFAULT 'MEDIUM',
  exhibit_label TEXT DEFAULT '',
  image_url TEXT DEFAULT '',
  image_url_2 TEXT DEFAULT '',
  description TEXT DEFAULT '',
  github_url TEXT DEFAULT '',
  live_url TEXT DEFAULT '',
  display_order INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Blog posts table
CREATE TABLE blog_posts (
  id BIGSERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  date TEXT DEFAULT '',
  content TEXT DEFAULT '',
  views INT DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Comments table
CREATE TABLE comments (
  id BIGSERIAL PRIMARY KEY,
  post_id INT REFERENCES blog_posts(id) ON DELETE CASCADE,
  text TEXT NOT NULL,
  author TEXT DEFAULT 'ANON_AGENT',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Likes table
CREATE TABLE likes (
  id BIGSERIAL PRIMARY KEY,
  post_id INT UNIQUE REFERENCES blog_posts(id) ON DELETE CASCADE,
  count INT DEFAULT 0
);

-- Admin settings
CREATE TABLE admin_settings (
  id BIGSERIAL PRIMARY KEY,
  key TEXT UNIQUE NOT NULL,
  value TEXT NOT NULL
);

-- Insert default admin password (change this after first login)
INSERT INTO admin_settings (key, value) VALUES ('password', 'admin123');

-- Enable RLS
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE blog_posts ENABLE ROW LEVEL SECURITY;
ALTER TABLE comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE likes ENABLE ROW LEVEL SECURITY;
ALTER TABLE admin_settings ENABLE ROW LEVEL SECURITY;

-- Allow public read
CREATE POLICY "Public read projects" ON projects FOR SELECT USING (true);
CREATE POLICY "Public read blog_posts" ON blog_posts FOR SELECT USING (true);
CREATE POLICY "Public read comments" ON comments FOR SELECT USING (true);
CREATE POLICY "Public read likes" ON likes FOR SELECT USING (true);

-- Allow all operations for anon (auth is handled in-app)
CREATE POLICY "Anon all projects" ON projects FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Anon all blog_posts" ON blog_posts FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Anon all comments" ON comments FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Anon all likes" ON likes FOR ALL USING (true) WITH CHECK (true);
CREATE POLICY "Anon all admin_settings" ON admin_settings FOR ALL USING (true) WITH CHECK (true);

-- Seed initial projects
INSERT INTO projects (name, codename, tagline, tech_stack, status, severity, exhibit_label, image_url, image_url_2, description, github_url, live_url, display_order) VALUES
('PROJECT OMEGA', 'omega', 'Fullstack Streaming Platform', ARRAY['React', 'Node.js', 'PostgreSQL'], 'ACTIVE', 'CRITICAL', 'EXHIBIT A-1',
 'https://lh3.googleusercontent.com/aida-public/AB6AXuAnSxIRAefH0x4DsitrkT8S7WHc5khkzz8soJPJdx5Mq7177TBH90MJsZpytHI5Ccvr40OQ_s0CJ7Hmu0yn5JgYOqIA70LqwzbH9Ca33SF1URrwdPJk6WCpTwCRvKyBvAT1rer2g8HkfQXORdHNAMOZR2XCNvpaIG92UBbllxwAyAFPvJ2lk8E0zzSlPFzUOWuH5djg0hBydUt6_Kd0IazTik9UNTeqM1mPkS_MrwrOd9t38-FgOS3hSw',
 'https://lh3.googleusercontent.com/aida-public/AB6AXuCv0NDij326wbtLIqpLirF23KZMESzTbWT5QP2qnip2oFJ7GPOULpJBa2MiTwKbQaWDzV1Mvc64sg5WoDFyZOahp_bk676i_hFzM7Bhwc4Yy9ccyO7fNbG5c6TxbM5VcYauCsllglpGhT3qaXKN1wCYaN6OHJpOH1v8Rc21GW7MLFPszD_Bev_pgjMsQZmHJpWkDENTaEk_Tz2aBy2PaeGDJfvwQcbOBXjZq6yxk_gpi-0-1t3n41N9zg',
 'A fullstack streaming platform capable of handling millions of concurrent users. Features real-time content delivery, personalized recommendation engine, and adaptive bitrate streaming.',
 'https://github.com/placeholder-omega', 'https://placeholder-omega.vercel.app', 1),

('THE SYNAPSE', 'synapse', 'AI Chat Interface', ARRAY['Python', 'FastAPI', 'OpenAI'], 'ACTIVE', 'HIGH', 'EXHIBIT B-2',
 'https://lh3.googleusercontent.com/aida-public/AB6AXuCv0NDij326wbtLIqpLirF23KZMESzTbWT5QP2qnip2oFJ7GPOULpJBa2MiTwKbQaWDzV1Mvc64sg5WoDFyZOahp_bk676i_hFzM7Bhwc4Yy9ccyO7fNbG5c6TxbM5VcYauCsllglpGhT3qaXKN1wCYaN6OHJpOH1v8Rc21GW7MLFPszD_Bev_pgjMsQZmHJpWkDENTaEk_Tz2aBy2PaeGDJfvwQcbOBXjZq6yxk_gpi-0-1t3n41N9zg',
 'https://lh3.googleusercontent.com/aida-public/AB6AXuCDc1kAaKusQptnLwSPEv-QqSpAa38BJ6y6_vjHPEPTSK-WDaA1E4CmWfyX1qWAo0AOMmV0L0KKwnK9jP3gA0eRKe_m_y1lgIKyb42q3RRKMBiCaYAtm0S2vDQpnR-PkIgbiDvIQFJIN1E8nTwJkFtQ9VfQu3LaqjDgx1cGBUHcKw6NHH8_SlCK0RxTxI-KCqZzOejPDPJU072ux3l4iBKEIfWGM5NMrSXmnWdWT-WJ3BhWw0bi4YT1TQ',
 'An advanced AI chat interface leveraging large language models for natural conversation. Features context-aware responses, multi-turn dialogue management.',
 'https://github.com/placeholder-synapse', 'https://placeholder-synapse.vercel.app', 2),

('GHOST PROTOCOL', 'ghost', 'Real-time Collaboration Hub', ARRAY['Next.js', 'TypeScript', 'Prisma'], 'PENDING', 'CRITICAL', 'EXHIBIT C-3',
 'https://lh3.googleusercontent.com/aida-public/AB6AXuCDc1kAaKusQptnLwSPEv-QqSpAa38BJ6y6_vjHPEPTSK-WDaA1E4CmWfyX1qWAo0AOMmV0L0KKwnK9jP3gA0eRKe_m_y1lgIKyb42q3RRKMBiCaYAtm0S2vDQpnR-PkIgbiDvIQFJIN1E8nTwJkFtQ9VfQu3LaqjDgx1cGBUHcKw6NHH8_SlCK0RxTxI-KCqZzOejPDPJU072ux3l4iBKEIfWGM5NMrSXmnWdWT-WJ3BhWw0bi4YT1TQ',
 'https://lh3.googleusercontent.com/aida-public/AB6AXuAnSxIRAefH0x4DsitrkT8S7WHc5khkzz8soJPJdx5Mq7177TBH90MJsZpytHI5Ccvr40OQ_s0CJ7Hmu0yn5JgYOqIA70LqwzbH9Ca33SF1URrwdPJk6WCpTwCRvKyBvAT1rer2g8HkfQXORdHNAMOZR2XCNvpaIG92UBbllxwAyAFPvJ2lk8E0zzSlPFzUOWuH5djg0hBydUt6_Kd0IazTik9UNTeqM1mPkS_MrwrOd9t38-FgOS3hSw',
 'A real-time collaboration platform enabling simultaneous editing, communication, and project management. Features end-to-end encryption and WebSocket-based live sync.',
 'https://github.com/placeholder-ghost', 'https://placeholder-ghost.vercel.app', 3),

('CIPHER HOUND', 'cipher', 'Cybersecurity Dashboard', ARRAY['React', 'Tailwind CSS'], 'CLOSED', 'MEDIUM', 'EXHIBIT D-4',
 'https://lh3.googleusercontent.com/aida-public/AB6AXuCyNsMK3iXnr3QqswNwaG9iaIMxcttFVfMYd31feFdP7pklNe43RiozTyd_Fe1ko2qZ29r6taKBaEEdAFUHCeugNQatoQSCwmDTLkN4ebKgm-XYDi5q8NP8OqCU_3ha0Rp742ozz6LHNF9SE_tDSSsK5hTFLDKdzibzOPgWIYd0WPPmzut3Rzgj6bL0cUqEQIbtHhGYzTLKD13AegP-rXsi0IKzt-1eWCa9XuZTFch0lB4dwHM3pZ7ocg',
 'https://lh3.googleusercontent.com/aida-public/AB6AXuCDc1kAaKusQptnLwSPEv-QqSpAa38BJ6y6_vjHPEPTSK-WDaA1E4CmWfyX1qWAo0AOMmV0L0KKwnK9jP3gA0eRKe_m_y1lgIKyb42q3RRKMBiCaYAtm0S2vDQpnR-PkIgbiDvIQFJIN1E8nTwJkFtQ9VfQu3LaqjDgx1cGBUHcKw6NHH8_SlCK0RxTxI-KCqZzOejPDPJU072ux3l4iBKEIfWGM5NMrSXmnWdWT-WJ3BhWw0bi4YT1TQ',
 'A comprehensive cybersecurity monitoring dashboard providing real-time threat detection, log analysis, and incident response tracking.',
 'https://github.com/placeholder-cipher', 'https://placeholder-cipher.vercel.app', 4);

-- Seed initial blog posts
INSERT INTO blog_posts (title, date, views, content) VALUES
('Why localization is not always the answer', '4/21/2026', 0,
 '<p class="mb-6 leading-relaxed">In the world of software development, localization is often presented as the gold standard for reaching global audiences. Translate the UI, adapt the formats, and you''re done. But in practice, localization introduces a host of complexities that can outweigh its benefits.</p><p class="mb-6 leading-relaxed">The cost of maintaining localized content at scale grows linearly with every language you add. Translation management, cultural adaptation, and region-specific compliance create an operational burden that many teams underestimate.</p><p class="mb-6 leading-relaxed">Sometimes, the smarter play is to focus on English-first with a clean, minimal interface that''s easy to understand globally. Not every product needs to speak every language.</p><p class="text-on-surface-variant italic">— Field Operative, Fullstack Division</p>'),

('Why developers make a sh*t ton of money', '4/10/2026', 0,
 '<p class="mb-6 leading-relaxed">Let''s cut through the noise. Developers are paid well because the gap between demand and supply is massive — and the leverage a single developer has over a business is enormous.</p><p class="mb-6 leading-relaxed">A single line of code can automate thousands of hours of manual labor. A well-architected system can scale to millions of users. That level of leverage commands high compensation.</p><p class="mb-6 leading-relaxed">So yes, developers make a lot of money. But it''s not because of entitlement. It''s because the value they create — and the scarcity of that skillset — earns it.</p><p class="text-on-surface-variant italic">— Field Operative, Fullstack Division</p>');

-- Seed initial likes
INSERT INTO likes (post_id, count) VALUES (1, 0), (2, 0);
