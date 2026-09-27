@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap');
@import url('./style.css');

body {
  font-family: 'Inter', sans-serif;
}

.glass-panel {
  background: rgba(255, 255, 255, 0.08);
  border: 1px solid rgba(255,255,255,0.12);
  box-shadow: 0 24px 50px rgba(8, 20, 33, 0.25);
  backdrop-filter: blur(18px);
  -webkit-backdrop-filter: blur(18px);
  border-radius: 24px;
}

.hero-card.primary,
.hero-card.secondary,
.service-card,
.news-card,
.gallery-card,
.contact-card,
.admin-highlight {
  background: rgba(255, 255, 255, 0.06);
  border: 1px solid rgba(255, 255, 255, 0.14);
  backdrop-filter: blur(18px);
  -webkit-backdrop-filter: blur(18px);
}
