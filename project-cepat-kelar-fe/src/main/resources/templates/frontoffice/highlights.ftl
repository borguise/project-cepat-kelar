<#-- FRAGMENT HIGHLIGHTS.FTL (FIGMA PIXEL-PERFECT PROPORTION) -->
<link href="https://fonts.googleapis.com/css2?family=Gelasio:ital,wght@0,400;0,700;1,700&family=Lato:wght@400;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    /* WADAH UTAMA: Memastikan konten berada tepat di tengah layar */
    .hl-wrapper { position: relative; min-height: 100%; width: 100%; padding: 40px; display: flex; flex-direction: column; justify-content: center; align-items: center; box-sizing: border-box; }
    .hl-bg { position: absolute; inset: 0; z-index: 0; pointer-events: none; opacity: 0.35; mix-blend-mode: multiply; background-image: url('${batikPath!"/images/frontoffice/batikspring.png"}'); background-size: 400px; background-repeat: repeat; }
    .hl-content { position: relative; z-index: 10; display: flex; flex-direction: column; width: 100%; max-width: 680px; /* Dipersempit sedikit agar proporsi kotaknya pas seperti Figma */ }
    
    /* HEADER */
    .hl-header { text-align: center; margin-bottom: 40px; }
    .hl-title { font-family: 'Gelasio', serif; font-size: 42px; font-weight: bold; color: #3f4e4f; margin-bottom: 16px; letter-spacing: 0.5px; }
    .hl-subtitle { font-family: 'Gelasio', serif; font-size: 18px; font-weight: 600; color: #52616b; line-height: 1.6; max-width: 650px; margin: 0 auto; text-align: center; }
    
    /* DAFTAR FAQ */
    .hl-faq-list { display: flex; flex-direction: column; gap: 16px; width: 100%; }
    
    /* DISEMBUNYIKAN CHECKBOX NYA */
    .faq-toggle { display: none; }
    
    /* DESAIN KARTU FAQ: Mengikuti gaya Transparan Figma */
    .faq-card {
        background-color: rgba(255, 255, 255, 0.45);
        backdrop-filter: blur(8px);
        border: 1px solid rgba(255, 255, 255, 0.5);
        border-radius: 8px; /* Sudut tidak terlalu bulat (mengikuti Figma) */
        transition: all 0.3s ease;
        overflow: hidden;
        width: 100%;
    }
    
    .faq-card:hover {
        background-color: rgba(255, 255, 255, 0.65);
    }
    
    /* BARIS PERTANYAAN */
    .faq-row { 
        padding: 22px 30px; 
        display: flex; 
        align-items: center; 
        cursor: pointer; 
        margin: 0; 
    }
    
    /* IKON PLUS: Di kiri, tanpa lingkaran (mengikuti Figma) */
    .faq-icon-plus { 
        font-size: 20px; 
        color: #3f4e4f; 
        width: 30px; /* Lebar tetap agar jadi jangkar */
        text-align: left;
        transition: transform 0.3s ease; 
        flex-shrink: 0;
    }

    /* RUANG KOSONG PENYEIMBANG: Diletakkan di kanan agar teks benar-benar di tengah */
    .faq-spacer {
        width: 30px; 
        flex-shrink: 0;
    }
    
    /* TEKS PERTANYAAN: Tepat di tengah */
    .faq-question { 
        text-align: center; 
        font-family: 'Gelasio', serif; 
        font-size: 18px; 
        font-weight: 700; 
        color: #3f4e4f; 
        margin: 0; 
        line-height: 1.4; 
        flex: 1; 
    }
    
    /* JAWABAN & ANIMASI BUKA/TUTUP */
    .faq-body { display: grid; grid-template-rows: 0fr; transition: grid-template-rows 0.3s ease; }
    .faq-content { overflow: hidden; }
    
    .faq-answer-box { padding: 0 40px 24px 40px; }
    .faq-answer-text { 
        color: #52616b; 
        font-size: 16px; 
        font-family: 'Lato', sans-serif; 
        font-weight: 500; 
        line-height: 1.6; 
        margin: 0; 
        padding-top: 20px; 
        border-top: 1px solid rgba(0,0,0,0.1); /* Garis pemisah yang sangat halus */
        text-align: center; /* Jawaban rata tengah mengikuti desain */
    }
    
    /* KETIKA DIKLIK / ACTIVE */
    .faq-toggle:checked + .faq-card { 
        background-color: rgba(255, 255, 255, 0.7); 
    }
    .faq-toggle:checked + .faq-card .faq-body { grid-template-rows: 1fr; }
    .faq-toggle:checked + .faq-card .faq-icon-plus { 
        transform: rotate(45deg); /* Berputar membentuk huruf X */
    }

    /* FOOTER */
    .hl-footer { margin-top: 50px; text-align: center; padding-bottom: 20px; }
    .hl-footer-text { font-family: 'Gelasio', serif; font-size: 16px; font-weight: 600; color: #52616b; line-height: 1.6; max-width: 550px; margin: 0 auto 24px auto; }
    .hl-social-box { display: flex; justify-content: center; gap: 20px; }
    
    /* IKON SOSIAL MEDIA: Garis tipis transparan mengikuti Figma */
    .hl-social-btn { 
        width: 45px; height: 45px; 
        border-radius: 50%; 
        border: 1.5px solid #52616b; 
        display: flex; align-items: center; justify-content: center; 
        color: #52616b; font-size: 20px; 
        text-decoration: none; transition: all 0.3s; 
    }
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
            <#if faqs?? && (faqs?size > 0)>
                <#list faqs as faq>
                    <div>
                        <input type="checkbox" id="faq-${faq_index}" class="faq-toggle">
                        <div class="faq-card">
                            <label class="faq-row" for="faq-${faq_index}">
                                <!-- Ikon Plus di Kiri -->
                                <span class="faq-icon-plus"><i class="fa-solid fa-plus"></i></span>
                                
                                <!-- Teks Pertanyaan di Tengah -->
                                <h3 class="faq-question">${faq.question!"-"}</h3>
                                
                                <!-- Penyeimbang di Kanan (Kosong tapi punya lebar sama dengan ikon plus) -->
                                <span class="faq-spacer"></span>
                            </label>
                            
                            <div class="faq-body">
                                <div class="faq-content">
                                    <div class="faq-answer-box">
                                        <div class="faq-answer-text">${faq.answer!"-"}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </#list>
            <#else>
                <div>
                    <input type="checkbox" id="faq-fallback" class="faq-toggle">
                    <div class="faq-card">
                        <label class="faq-row" for="faq-fallback">
                            <span class="faq-icon-plus"><i class="fa-solid fa-plus"></i></span>
                            <h3 class="faq-question">Belum ada informasi sorotan.</h3>
                            <span class="faq-spacer"></span>
                        </label>
                        <div class="faq-body">
                            <div class="faq-content">
                                <div class="faq-answer-box">
                                    <div class="faq-answer-text">Data belum ditambahkan dari halaman Admin.</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </#if>
        </div>

        <div class="hl-footer">
            <p class="hl-footer-text">${footerDesc!"Masih belum menemukan jawaban yang kamu suka? atau kamu memerlukan informasi tambahan? Jangan khawatir kamu bisa menghubungi kami langsung lewat sini"}</p>
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