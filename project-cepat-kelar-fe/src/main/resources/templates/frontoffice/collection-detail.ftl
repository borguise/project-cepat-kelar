<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="icon" type="image/png" href="/images/backoffice/Ellipse 2.png">
    <title>${(book.title)!"Detail Koleksi"} - Graha Pusat Literasi</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Gelasio:wght@400;700&family=Lato:wght@400;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <!-- FontAwesome untuk Ikon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { 
            background-color: #1e293b; /* Warna latar gelap di luar layar Kiosk */
            margin: 0; padding: 0; 
            height: 100vh; width: 100vw; overflow: hidden; 
            display: flex; justify-content: center; align-items: center; 
        }
        
        /* KANVAS KIOSK UTAMA: 864x1536px */
        #koleksi-canvas {
            width: 864px; height: 1536px;
            background-color: #f7f0cb; 
            position: relative; overflow: hidden;
            box-shadow: 0 0 50px rgba(0,0,0,0.6);
            transform-origin: center center;
            font-family: 'Inter', sans-serif;
        }

        /* Latar Belakang Batik Halus */
        .batik-bg {
            position: absolute; inset: 0;
            background-image: url('${batikPath!"/images/frontoffice/batikspring.png"}');
            background-size: 520px; opacity: 0.12; mix-blend-mode: multiply; pointer-events: none;
        }
    </style>
</head>
<body>

    <div id="koleksi-canvas">
        <div class="batik-bg"></div>

        <!-- HEADER & NAVIGASI -->
        <div class="w-full flex justify-between items-center px-12 pt-16 relative z-20">
            <!-- Tombol Kembali -->
            <a href="javascript:void(0)" onclick="window.history.back()" class="flex items-center gap-3 px-6 py-4 bg-white rounded-full shadow-sm text-sky-500 hover:text-sky-600 font-['Lato'] font-bold text-2xl transition active:scale-95">
                <i class="fas fa-chevron-left"></i> Kembali ke daftar koleksi
            </a>
            <!-- Tombol X (Tutup) -->
            <div class="w-16 h-16 bg-white rounded-full shadow-sm flex items-center justify-center text-slate-400 hover:text-red-500 cursor-pointer transition text-3xl active:scale-95" onclick="window.history.back()">
                <i class="fas fa-times"></i>
            </div>
        </div>

        <!-- AREA KONTEN UTAMA -->
        <div class="w-full px-12 mt-12 relative z-20">
            <div class="bg-white/95 backdrop-blur-sm rounded-[40px] p-[60px] shadow-xl w-full flex flex-col gap-12 border border-white/50">
                
                <!-- IDENTITAS BUKU (SAMPUL & JUDUL) -->
                <div class="flex gap-[50px] items-start">
                    <!-- Kotak Sampul Buku -->
                    <div class="w-[260px] h-[380px] shrink-0 rounded-[16px] overflow-hidden border-[4px] border-slate-100 shadow-lg bg-slate-50 flex items-center justify-center">
                        <!-- Fitur OnError: Jika gambar gagal dimuat, tampilkan gambar abu-abu -->
                        <img src="${(book.cover)!''}" alt="Cover Koleksi" class="w-full h-full object-cover" 
                             onerror="this.src='https://placehold.co/400x600/f1f5f9/94a3b8?text=Tidak+Ada+Cover'">
                    </div>
                    
                    <!-- Meta Data -->
                    <div class="flex-1 flex flex-col justify-center py-4">
                        <h1 class="font-['Gelasio'] font-bold text-[46px] leading-[1.2] text-slate-900 mb-6">
                            ${(book.title)!"Judul Tidak Tersedia"}
                        </h1>
                        <div class="font-['Gelasio'] font-bold text-[65px] text-[#3730a3] leading-none mb-4">
                            ${(book.callNumber)!"-"}
                        </div>
                        <div class="font-['Gelasio'] font-bold text-[32px] text-slate-400 uppercase tracking-widest">
                            ${(book.category)!"Koleksi Umum"}
                        </div>
                    </div>
                </div>

                <!-- KOTAK KETERANGAN DETIL -->
                <div class="w-full border-t-2 border-slate-100 pt-10">
                    <h2 class="font-['Gelasio'] font-bold text-[36px] text-slate-900 mb-8 flex items-center gap-4">
                        <i class="fas fa-book-open text-sky-500"></i> Keterangan Buku
                    </h2>
                    
                    <div class="flex flex-col gap-6">
                        <!-- Tajuk Pengarang -->
                        <div class="bg-slate-50 rounded-[24px] p-[35px] border-2 border-slate-100 transition hover:border-sky-200 hover:bg-sky-50/30">
                            <div class="font-['Gelasio'] text-[24px] text-slate-400 uppercase mb-2">Tajuk Pengarang</div>
                            <div class="font-['Gelasio'] font-bold text-[34px] text-slate-800">${(book.author)!"-"}</div>
                        </div>

                        <!-- Data Penerbit -->
                        <div class="bg-slate-50 rounded-[24px] p-[35px] border-2 border-slate-100 transition hover:border-sky-200 hover:bg-sky-50/30">
                            <div class="font-['Gelasio'] text-[24px] text-slate-400 uppercase mb-2">Data Penerbit</div>
                            <div class="font-['Gelasio'] font-bold text-[34px] text-slate-800 leading-snug">${(book.publisher)!"-"}</div>
                        </div>

                        <!-- Data Fisik -->
                        <div class="bg-slate-50 rounded-[24px] p-[35px] border-2 border-slate-100 transition hover:border-sky-200 hover:bg-sky-50/30">
                            <div class="font-['Gelasio'] text-[24px] text-slate-400 uppercase mb-2">Data Fisik</div>
                            <div class="font-['Gelasio'] font-bold text-[34px] text-slate-800">${(book.physicalData)!"-"}</div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <script>
        // FUNGSI SCALING: Mengukur layar monitor dan mengecilkan kanvas Kiosk secara otomatis
        function scaleCanvas() {
            const canvas = document.getElementById('koleksi-canvas');
            const windowHeight = window.innerHeight;
            // Menghitung rasio skala agar muat penuh di tinggi layar
            const scale = windowHeight / 1536; 
            canvas.style.transform = "scale(" + scale + ")";
        }
        
        window.addEventListener('load', scaleCanvas);
        window.addEventListener('resize', scaleCanvas);
    </script>
</body>
</html>