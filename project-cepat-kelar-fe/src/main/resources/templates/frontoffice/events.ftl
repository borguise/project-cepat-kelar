<#-- events.ftl - VERSI KIOSK BESAR (ALWAYS SHOW CONTENT) -->
<link href="https://fonts.googleapis.com/css2?family=Gelasio:wght@400;700&family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    .kiosk-agenda-container {
        background-color: #f7f0cb; 
        background-image: url('${batikPath!"/images/frontoffice/batikspring.png"}');
        background-repeat: repeat;
        background-blend-mode: multiply;
        min-height: 100%; width: 100%;
        padding: 100px 50px;
        font-family: 'Gelasio', serif;
        display: flex; flex-direction: column; align-items: center;
    }

    .kiosk-main-title {
        font-size: 72px; font-weight: 700; color: #1a1a1a;
        text-align: center; margin-bottom: 60px; letter-spacing: -2px;
    }

    .kiosk-card {
        width: 100%; max-width: 800px;
        background: rgba(255, 255, 255, 0.98);
        border-radius: 60px;
        box-shadow: 0 40px 80px rgba(0,0,0,0.15);
        overflow: hidden;
        animation: fadeInUp 0.8s cubic-bezier(0.22, 1, 0.36, 1);
    }

    .kiosk-card-header { padding: 80px 60px 40px; display: flex; flex-direction: column; align-items: center; text-align: center; }
    .kiosk-event-name { font-size: 64px; font-weight: 700; color: #0f172a; line-height: 1.1; margin-bottom: 20px; }
    .kiosk-divider { width: 120px; height: 8px; background: #f7f0cb; margin-bottom: 50px; border-radius: 4px; }

    .kiosk-image-placeholder {
        width: 100%; height: 450px; background-color: #f8fafc; border-radius: 40px;
        display: flex; justify-content: center; align-items: center; margin-bottom: 50px; border: 3px dashed #e2e8f0;
    }

    .kiosk-date-row { display: flex; align-items: center; gap: 25px; font-size: 48px; font-weight: 600; color: #1e293b; margin-bottom: 60px; }
    .kiosk-label { font-family: 'Inter', sans-serif; font-size: 28px; font-weight: 700; color: #94a3b8; text-transform: uppercase; letter-spacing: 5px; margin-bottom: 40px; }
    
    .kiosk-desc-box { padding: 0 60px 60px; }
    .kiosk-desc-content { background: #fcfcfc; padding: 50px; border-radius: 35px; border: 1px solid #f1f5f9; font-size: 42px; text-align: center; color: #475569; line-height: 1.6; }

    .kiosk-next-section { background: #fafaf7; padding: 60px; border-top: 2px solid #f1f5f9; }
    .next-label { font-size: 32px; font-weight: 700; color: #1e293b; opacity: 0.7; text-transform: uppercase; margin-bottom: 40px; }

    .next-card { background: white; border-radius: 30px; padding: 35px; margin-bottom: 30px; display: flex; align-items: center; gap: 35px; box-shadow: 0 10px 20px rgba(0,0,0,0.03); }
    .next-icon-box { width: 90px; height: 90px; background: #f7f0cb; border-radius: 20px; display: flex; align-items: center; justify-content: center; font-size: 40px; color: #1a1a1a; }
    .next-info h3 { font-size: 36px; font-weight: 700; margin: 0; color: #0f172a; }
    .next-info span { font-family: 'Inter', sans-serif; font-size: 28px; color: #94a3b8; }

    @keyframes fadeInUp { from { opacity: 0; transform: translateY(60px); } to { opacity: 1; transform: translateY(0); } }
</style>

<div class="kiosk-agenda-container">
    <h1 class="kiosk-main-title">Agenda Kegiatan Literasi</h1>

    <div class="kiosk-card">
        <#-- VARIABEL LOKAL UNTUK TESTING & FALLBACK -->
        <#assign title = (events[0].title)!"Kunjungan berkelompok Smp">
        <#assign date = (events[0].formattedDate)!"12, maret 2027">
        <#assign desc = (events[0].description)!"Teman-teman siswa mendapat tugas untuk menjelajahi literasi di Graha Pusat Literasi.">

        <div class="kiosk-card-header">
            <div class="kiosk-event-name">${title}</div>
            <div class="kiosk-divider"></div>

            <div class="kiosk-image-placeholder">
                <#if (events[0].imagePath)??>
                    <img src="${events[0].imagePath}" class="w-full h-full object-cover rounded-[36px]">
                <#else>
                    <svg width="240" height="240" viewBox="0 0 24 24" fill="none" opacity="0.3">
                        <circle cx="12" cy="8" r="4" fill="#64748b"/>
                        <path d="M20 19C20 17.3431 16.4183 16 12 16C7.58172 16 4 17.3431 4 19V20H20V19Z" fill="#64748b"/>
                    </svg>
                </#if>
            </div>

            <div class="kiosk-date-row">
                <i class="fa-regular fa-calendar-days text-[#94a3b8]"></i>
                <span>${date}</span>
            </div>

            <div class="kiosk-label">Deskripsi Kegiatan</div>
        </div>

        <div class="kiosk-desc-box">
            <div class="kiosk-desc-content">${desc}</div>
        </div>

        <div class="kiosk-next-section">
            <div class="next-label">Agenda Selanjutnya</div>
            
            <#-- Loop Agenda Selanjutnya (Dummy jika DB kosong) -->
            <#if events?? && (events?size > 1)>
                <#list events as item>
                    <#if item?index != 0>
                        <div class="next-card">
                            <div class="next-icon-box"><i class="fa-solid fa-book-open"></i></div>
                            <div class="next-info"><h3>${item.title}</h3><span>${item.formattedDate}</span></div>
                        </div>
                    </#if>
                </#list>
            <#else>
                <#-- Statis Fallback agar tetap keren saat dipresentasikan -->
                <div class="next-card">
                    <div class="next-icon-box"><i class="fa-solid fa-book-open"></i></div>
                    <div class="next-info"><h3>Bedah Buku Sejarah</h3><span>15 Maret 2027</span></div>
                </div>
                <div class="next-card">
                    <div class="next-icon-box"><i class="fa-solid fa-microphone-lines"></i></div>
                    <div class="next-info"><h3>Workshop Literasi</h3><span>18 Maret 2027</span></div>
                </div>
            </#if>
        </div>
    </div>
    <div class="h-40"></div>
</div>