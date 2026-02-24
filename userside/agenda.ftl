<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agenda Literasi - ${agendaUtama.judul!'Kegiatan Literasi'}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Gelasio:wght@400;700&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        * { box-sizing: border-box; }
        body { 
            background-color: #1a1a1a; margin: 0; padding: 0; 
            height: 100vh; overflow: hidden; 
            display: flex; justify-content: center; align-items: flex-start; 
        }

        /* --- KANVAS KIOSK DENGAN BATIK MULTIPLY --- */
        .OverlayKalender {
            width: 864px; height: 1920px;
            background-color: #f7f0cb; 
            background-image: url('${basePath!}/assets/img/batikspring.png');
            background-repeat: repeat;
            background-blend-mode: multiply;
            position: relative; overflow: hidden;
            transform-origin: top center;
            box-shadow: 0 0 100px rgba(0,0,0,0.5);
        }

        /* TOMBOL SILANG */
        .close-btn { 
            position: absolute; top: 30px; right: 45px; 
            font-family: 'Inter', sans-serif; font-size: 60px; 
            font-weight: 300; color: #1a1a1a; cursor: pointer; z-index: 100; 
        }
        
        /* JUDUL HALAMAN */
        .AgendaTitle {
            position: absolute; top: 180px; left: 0; right: 0;
            text-align: center; font-family: 'Gelasio', serif; 
            font-size: 72px; font-weight: 700; color: #1a1a1a;
            letter-spacing: -2px;
            animation: fadeInTitle 1.5s ease-out forwards;
        }

        /* KARTU PUTIH DENGAN ANIMASI */
        .WrapperCard {
            position: absolute; 
            top: 420px; left: 52px;
            width: 760px; height: 1250px; 
            background: rgba(255, 255, 255, 0.98); 
            border-radius: 56px;
            box-shadow: 0 50px 100px rgba(0,0,0,0.15);
            overflow-y: auto; scrollbar-width: none;
            display: flex; flex-direction: column;
            opacity: 0;
            transform: translateY(100px);
            animation: fadeInUp 1s cubic-bezier(0.22, 1, 0.36, 1) forwards;
            animation-delay: 0.3s;
        }
        .WrapperCard::-webkit-scrollbar { display: none; }

        @keyframes fadeInUp { to { opacity: 1; transform: translateY(0); } }
        @keyframes fadeInTitle { from { opacity: 0; } to { opacity: 1; } }

        .MainView { padding: 90px 60px 40px 60px; display: flex; flex-direction: column; align-items: center; }
        .KunjunganTitle { font-family: 'Gelasio', serif; font-size: 68px; font-weight: 700; text-align: center; color: #0f172a; margin-bottom: 20px; line-height: 1.1; }
        .divider { width: 120px; height: 8px; background: #f7f0cb; margin: 0 auto 50px auto; border-radius: 4px; }

        .VectorPlaceholder {
            width: 100%; height: 420px;
            background-color: #f8fafc; border-radius: 36px;
            display: flex; justify-content: center; align-items: center;
            margin-bottom: 50px; border: 2.5px dashed #e2e8f0;
            overflow: hidden;
        }

        .DateContainer { 
            display: flex; align-items: center; justify-content: center; gap: 20px; 
            color: #1e293b; font-family: 'Gelasio', serif; font-size: 44px; font-weight: 600;
            margin-bottom: 120px;
        }

        /* DESKRIPSI */
        .DescriptionLabel {
            font-family: 'Inter', sans-serif; font-size: 28px; font-weight: 700;
            color: #94a3b8; text-transform: uppercase; letter-spacing: 4px;
        }
        .HiddenContent { padding: 20px 65px 100px 65px; background: white; }
        .DescriptionBox { background: #fcfcfc; padding: 45px; border-radius: 28px; border: 1px solid #f1f5f9; margin-bottom: 60px; }
        .DescriptionText { font-family: 'Gelasio', serif; font-size: 40px; text-align: center; color: #475569; line-height: 1.6; }

        /* AGENDA SELANJUTNYA */
        .NextAgenda { padding: 60px; background: #fafaf7; border-top: 1px solid #f1f5f9; border-bottom-left-radius: 56px; border-bottom-right-radius: 56px; }
        .NextCard {
            background: white; border-radius: 24px; padding: 30px; margin-bottom: 25px;
            display: flex; align-items: center; gap: 30px; box-shadow: 0 6px 15px rgba(0,0,0,0.04);
        }
    </style>
</head>
<body>

    <div id="kios-canvas" class="OverlayKalender">
        <div class="close-btn" onclick="location.href='${basePath!}/home'">x</div>

        <h1 class="AgendaTitle">Agenda Kegiatan Literasi</h1>

        <div class="WrapperCard">
            <div class="VisibleContent MainView">
                <div class="KunjunganTitle">${agendaUtama.judul!'Kunjungan Berkelompok'}</div>
                <div class="divider"></div>

                <div class="VectorPlaceholder">
                    <#if agendaUtama.imageUrl??>
                        <img src="${agendaUtama.imageUrl}" class="w-full h-full object-cover">
                    <#else>
                        <svg width="240" height="240" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" opacity="0.3">
                            <circle cx="12" cy="8" r="4" fill="#64748b"/>
                            <path d="M20 19C20 17.3431 16.4183 16 12 16C7.58172 16 4 17.3431 4 19V20H20V19Z" fill="#64748b"/>
                        </svg>
                    </#if>
                </div>

                <div class="DateContainer">
                    <i class="fa-regular fa-calendar-days" style="color: #94a3b8; font-size: 40px;"></i>
                    <span>${agendaUtama.tanggalFormat!'Tanggal Belum Tersedia'}</span>
                </div>

                <div class="DescriptionLabel">Deskripsi Kegiatan</div>
            </div>

            <div class="HiddenContent">
                <div class="DescriptionBox">
                    <div class="DescriptionText">
                        ${agendaUtama.deskripsi!'Teman-teman siswa mendapat tugas untuk menjelajahi literasi'}
                    </div>
                </div>

                <div class="NextAgenda">
                    <div class="text-3xl font-bold font-['Gelasio'] mb-8 text-slate-800 opacity-70 uppercase tracking-widest">Agenda Selanjutnya</div>
                    
                    <#if listAgendaSelanjutnya?? && (listAgendaSelanjutnya?size > 0)>
                        <#list listAgendaSelanjutnya as next>
                            <div class="NextCard" onclick="location.href='${basePath!}/agenda/detail?id=${next.id}'">
                                <div class="w-20 h-20 bg-[#f7f0cb] rounded-xl flex items-center justify-center text-3xl">
                                    <i class="fa-solid ${next.iconClass!'fa-book-open'}"></i>
                                </div>
                                <div>
                                    <div class="text-3xl font-bold font-['Gelasio']">${next.judul}</div>
                                    <div class="text-2xl text-slate-400 font-['Inter']">${next.tanggalFormat}</div>
                                </div>
                            </div>
                        </#list>
                    <#else>
                        <div class="text-2xl text-slate-400 font-['Inter'] italic">Belum ada agenda mendatang.</div>
                    </#if>
                </div>
            </div>
        </div>
    </div>

    <script>
        function applyScaling() {
            const canvas = document.getElementById('kios-canvas');
            const windowH = window.innerHeight;
            canvas.style.transform = `scale(${(windowH - 20) / 1920})`;
        }
        window.addEventListener('load', applyScaling);
        window.addEventListener('resize', applyScaling);
    </script>
</body>
</html>