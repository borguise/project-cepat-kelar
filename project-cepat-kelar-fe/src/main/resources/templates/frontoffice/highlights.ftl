<#-- FRAGMENT HIGHLIGHTS.FTL (DESAIN MURNI TANPA TAILWIND - ANTI BADAI) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    /* --- WADAH UTAMA --- */
    .hl-wrapper {
        position: relative; min-height: 100%; width: 100%;
        padding: 70px 50px; display: flex; flex-direction: column;
        justify-content: center; align-items: center; box-sizing: border-box;
    }
    .hl-bg {
        position: absolute; inset: 0; z-index: 0; pointer-events: none;
        opacity: 0.3; mix-blend-mode: multiply;
        background-image: url('${batikPath!"/images/frontoffice/batikspring.png"}');
        background-size: 400px; background-repeat: repeat;
    }
    
    /* --- KONTEN TENGAH --- */
    .hl-content {
        position: relative; z-index: 10; display: flex; flex-direction: column;
        width: 100%; max-width: 800px;
    }
    
    /* --- HEADER --- */
    .hl-header { text-align: center; margin-bottom: 50px; }
    .hl-title { font-family: 'Gelasio', serif; font-size: 54px; font-weight: bold; color: #475569; margin-bottom: 24px; letter-spacing: 1px; line-height: 1.2; }
    .hl-subtitle { font-family: 'Gelasio', serif; font-size: 22px; font-weight: bold; color: #475569; line-height: 1.8; max-width: 750px; margin: 0 auto; }
    
    /* --- ACCORDION FAQ --- */
    .hl-faq-list { display: flex; flex-direction: column; gap: 24px; width: 100%; }
    .faq-row { background-color: rgba(255, 255, 255, 0.45); backdrop-filter: blur(4px); transition: background-color 0.3s ease; position: relative; padding: 24px 32px; display: flex; align-items: center; cursor: pointer; box-shadow: 0 1px 3px rgba(0,0,0,0.1); border-radius: 8px; }
    .faq-row:hover { background-color: rgba(255, 255, 255, 0.65); }
    .faq-icon-plus { position: absolute; left: 40px; font-family: monospace; font-size: 32px; font-weight: bold; color: #334155; transition: transform 0.3s ease; line-height: 1; }
    .faq-row.active .faq-icon-plus { transform: rotate(45deg); }
    .faq-question { width: 100%; text-align: center; font-family: 'Gelasio', serif; font-size: 24px; font-weight: bold; color: #334155; padding: 0 40px; margin: 0; }
    
    .faq-body { display: grid; grid-template-rows: 0fr; transition: grid-template-rows 0.4s ease; }
    .faq-row.active + .faq-body { grid-template-rows: 1fr; margin-bottom: 30px; }
    .faq-content { overflow: hidden; }
    .faq-answer-box { padding: 24px 64px; text-align: center; }
    .faq-answer-text { color: #475569; font-size: 20px; font-family: 'Lato', sans-serif; font-weight: 500; line-height: 1.6; font-style: italic; margin: 0; }
    
    /* --- FOOTER & SOCIAL --- */
    .hl-footer { margin-top: 50px; text-align: center; padding-bottom: 16px; }
    .hl-footer-text { font-family: 'Gelasio', serif; font-size: 22px; font-weight: bold; color: #475569; line-height: 1.6; max-width: 650px; margin: 0 auto 32px auto; }
    .hl-social-box { display: flex; justify-content: center; gap: 40px; }
    .hl-social-btn { width: 70px; height: 70px; border-radius: 50%; border: 2px solid #475569; display: flex; align-items: center; justify-content: center; color: #475569; font-size: 32px; text-decoration: none; transition: all 0.3s; }
    .hl-social-btn.wa:hover { background-color: #25D366; color: white; border-color: #25D366; }
    .hl-social-btn.ig:hover { background-color: #E1306C; color: white; border-color: #E1306C; }
</style>

<div class="hl-wrapper">
    <div class="hl-bg"></div>
    
    <div class="hl-content">
        <div class="hl-header">
            <h2 class="hl-title">${mainTitle!"Highlights"}</h2>
            <p class="hl-subtitle">${subTitle!"Pertanyaanmu penting, dan kami siap menjawab pertanyaan mu disini. Semua yang ingin kamu ketahui kami rangkum dalam satu tempat. Temukan jawaban atas pertanyaan yang paling sering ditanyakan disini."}</p>
        </div>

        <div class="hl-faq-list">
            <#if faqs?? && faqs?has_content>
                <#list faqs as faq>
                    <#if faq?index == 3><#break></#if> 
                    <div>
                        <div class="faq-row" onclick="this.classList.toggle('active')">
                            <span class="faq-icon-plus">+</span>
                            <h3 class="faq-question">${faq.question}</h3>
                        </div>
                        <div class="faq-body">
                            <div class="faq-content">
                                <div class="faq-answer-box">
                                    <p class="faq-answer-text">${faq.answer}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </#list>
            <#else>
                <div>
                    <div class="faq-row" onclick="this.classList.toggle('active')">
                        <span class="faq-icon-plus">+</span>
                        <h3 class="faq-question">Bagaimana cara menjadi anggota perpustakaan?</h3>
                    </div>
                    <div class="faq-body">
                        <div class="faq-content">
                            <div class="faq-answer-box">
                                <p class="faq-answer-text">Pendaftaran sangat mudah dan gratis. Anda hanya perlu datang ke meja resepsionis di Lantai 1 dengan membawa KTP, KIA, atau Kartu Pelajar. Prosesnya hanya memakan waktu 10 menit.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div>
                    <div class="faq-row" onclick="this.classList.toggle('active')">
                        <span class="faq-icon-plus">+</span>
                        <h3 class="faq-question">Bagaimana cara mengajukan kegiatan kunjungan bersama?</h3>
                    </div>
                    <div class="faq-body">
                        <div class="faq-content">
                            <div class="faq-answer-box">
                                <p class="faq-answer-text">Sekolah atau instansi dapat mengirimkan surat permohonan kunjungan ke email resmi kami atau menyerahkannya langsung ke petugas resepsionis minimal 3 hari sebelum jadwal kunjungan.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div>
                    <div class="faq-row" onclick="this.classList.toggle('active')">
                        <span class="faq-icon-plus">+</span>
                        <h3 class="faq-question">Apa saja fasilitas dan layanan yang disediakan di Graha Pusat Literasi?</h3>
                    </div>
                    <div class="faq-body">
                        <div class="faq-content">
                            <div class="faq-answer-box">
                                <p class="faq-answer-text">Kami menyediakan area baca yang nyaman, akses Wi-Fi gratis, Soundproof Pod untuk audiobook, ruang koleksi khusus Sejarah Magetan, serta Kotak Suara untuk menyalurkan aspirasi literasi Anda.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </#if>
        </div>

        <div class="hl-footer">
            <p class="hl-footer-text">${footerDesc!"Masih belum menemukan jawaban yang kamu suka? atau kamu memrlukan informasi tambahan? Jangan khawatir kamu bisa menghubungi kami langsung lewat sini:"}</p>
            <div class="hl-social-box">
                <a href="${whatsappLink!"https://wa.me/6285706380204"}" target="_blank" rel="noopener noreferrer" class="hl-social-btn wa">
                    <i class="fab fa-whatsapp"></i>
                </a>
                <a href="${instagramLink!"https://www.instagram.com/magetan_library/"}" target="_blank" rel="noopener noreferrer" class="hl-social-btn ig">
                    <i class="fab fa-instagram"></i>
                </a>
            </div>
        </div>
    </div>
</div>