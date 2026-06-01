<#-- =======================================================
     ARTICLES.FTL - KIOSK SPA SINGLE FILE (BERITA & DETAIL)
     Adopsi Mutlak Sistem SPA Koleksi - 100% Bebas Error 500
     ======================================================= -->

<style>
    /* Mengamankan area gulir dan visual khas Magetan */
    .art-scroll-area::-webkit-scrollbar { display: none; }
    .art-scroll-area { scrollbar-width: none; overflow-y: auto; height: 100%; width: 100%; padding-bottom: 100px; position: relative; z-index: 10; }
    
    .art-batik-layer {
        position: absolute; inset: 0;
        background-image: url('${batikPath!"/images/frontoffice/batikspring.png"}'); 
        background-size: 520px; opacity: 0.12; mix-blend-mode: multiply;
        pointer-events: none; z-index: 1;
    }

    /* Tipografi & Gaya Spesifik Desain Figma Detail */
    @import url('https://fonts.googleapis.com/css2?family=Gelasio:ital,wght@0,400;0,700;1,700&family=Lato:wght@400;700&display=swap');
    
    .fg-title { font-family: 'Gelasio', serif; color: #3B5998; font-size: 42px; font-weight: bold; text-align: center; margin-bottom: 30px; line-height: 1.2; }
    .fg-image { width: 100%; height: 400px; object-fit: cover; border-radius: 16px; margin-bottom: 30px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
    .fg-content { font-family: 'Lato', sans-serif; color: #334155; font-size: 20px; line-height: 1.8; text-align: justify; margin-bottom: 50px; }
    .fg-content p { margin-bottom: 20px; }

    /* Komponen Komentar Sesuai Prototipe */
    .fg-comment-box { background-color: #E2E8F0; border-radius: 24px; padding: 40px; margin-bottom: 40px; display: flex; flex-direction: column; gap: 20px; }
    .fg-input { width: 100%; padding: 18px 24px; border-radius: 12px; border: none; font-family: 'Lato', sans-serif; font-size: 16px; color: #333; outline: none; box-sizing: border-box; }
    .fg-textarea-wrapper { position: relative; width: 100%; }
    .fg-textarea { width: 100%; padding: 18px 24px; border-radius: 12px; border: none; height: 120px; resize: none; font-family: 'Lato', sans-serif; font-size: 16px; color: #333; outline: none; box-sizing: border-box; }
    .fg-submit-btn { position: absolute; bottom: 15px; right: 20px; background: transparent; border: none; font-size: 24px; color: #3B5998; cursor: pointer; }
    
    .fg-comment-list { display: flex; flex-direction: column; gap: 20px; margin-top: 20px; }
    .fg-comment-item { display: flex; gap: 20px; align-items: flex-start; }
    .fg-avatar { width: 50px; height: 50px; border-radius: 50%; background-color: #3B5998; color: white; display: flex; justify-content: center; align-items: center; font-size: 20px; flex-shrink: 0; }
    .fg-comment-text-area { display: flex; flex-direction: column; gap: 4px; padding-top: 4px; }
    .fg-comment-name { font-family: 'Lato', sans-serif; font-size: 16px; font-weight: bold; color: #3B5998; }
    .fg-comment-isi { font-family: 'Lato', sans-serif; font-size: 16px; color: #475569; line-height: 1.5; }
</style>

<div class="w-full h-full bg-[#f7f0cb] relative overflow-hidden">
    
    <div class="art-batik-layer"></div>

    <div class="art-scroll-area flex flex-col items-center">
        
        <#-- ================= 1. BROWSE VIEW (DAFTAR GRID 3x3) ================= -->
        <div id="artViewBrowse" class="w-full max-w-[800px] flex flex-col items-center flex">
            
            <#-- Jarak Banner Atas -->
            <div class="w-full mt-[120px]"></div>

            <#-- Wadah Utama Berita -->
            <div class="w-full bg-white/95 backdrop-blur-sm rounded-[40px] p-[60px] shadow-sm min-h-[600px] mb-10">
                
                <#-- Grid Kontainer Utama -->
                <div id="artGridContainer" class="grid grid-cols-3 gap-[50px_30px]">
                    <#-- Konten akan diinjeksi secara instan oleh JavaScript di bawah -->
                </div>
                
            </div>
        </div>

        <#-- ================= 2. DETAIL VIEW (DESAIN FIGMA TERPADU) ================= -->
        <div id="artViewDetail" class="hidden w-full max-w-[800px] flex-col items-center mt-[120px]">
            
            <#-- Tombol Kembali ke Tengah Sesuai Aturan Kiosk -->
            <div class="w-full flex justify-center mb-[25px] relative z-20">
                <div class="font-['Lato'] text-[24px] font-bold text-sky-500 cursor-pointer flex items-center gap-3 bg-white px-6 py-3 rounded-full shadow-sm hover:text-sky-600 transition" onclick="artGoBack()">
                    <i class="fas fa-chevron-left"></i> Kembali ke daftar berita
                </div>
            </div>

            <#-- Kotak Isi Artikel Utama -->
            <div class="w-full bg-white/95 backdrop-blur-sm rounded-[40px] p-[60px] shadow-xl flex flex-col mb-[80px]">
                <div class="fg-wrapper">
                    
                    <h1 id="artDtlTitle" class="fg-title">Judul Berita</h1>
                    <img id="artDtlImg" src="" class="fg-image" alt="Gambar Berita">

                    <div id="artDtlContent" class="fg-content">
                        <#-- Isi teks paragraf masuk ke sini -->
                    </div>

                    <#-- Formulir Komentar Aktif -->
                    <form action="/submit-comment" method="POST" class="fg-comment-box">
                        <input type="hidden" id="artDtlIdField" name="articleId" value="">
                        <input type="email" name="email" placeholder="Email" class="fg-input" required>
                        <input type="password" name="password" placeholder="Password" class="fg-input">
                        
                        <div class="fg-textarea-wrapper">
                            <textarea name="comment" placeholder="Tuliskan Komentar anda disini" class="fg-textarea" required></textarea>
                            <button type="submit" class="fg-submit-btn">
                                <i class="fa-regular fa-paper-plane"></i>
                            </button>
                        </div>
                    </form>

                    <#-- Daftar Komentar Bawaan -->
                    <div class="fg-comment-list">
                        <div class="fg-comment-item">
                            <div class="fg-avatar"><i class="fa-solid fa-user"></i></div>
                            <div class="fg-comment-text-area">
                                <div class="fg-comment-name">Admin Graha Pusat Literasi</div>
                                <div class="fg-comment-isi">Belum ada komentar pada artikel ini. Jadilah yang pertama memberikan pendapat Anda!</div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </div>
</div>

<script>
    <#-- 1. DATABASE LOKAL 10 DUMMY DATA AGAR GRID 3x3 TEMPIL SEMPURNA -->
    const artDbArticles = [
        <#if articles?? && articles?has_content>
            <#list articles as a>
            { id: ${a.id}, title: "${(a.title!'')?js_string}", content: "${(a.content!'')?js_string}", img: "/admin/articles/image/${a.id}" }<#if a?has_next>,</#if>
            </#list>
        <#else>
            { id: 1, title: "Memori Milik Kita", content: "<p>Literasi tidak berhenti pada membaca, Di Graha Pusat Literasi, literasi bergerak lebih jauh: menjadi aksi, eksperimen, dan penciptaan makna. Melalui ruang lab komputer, pengunjung diajak melangkah dari rasa ingin tahu menuju pengalaman memahami informasi secara aktif.</p><p>Ketika jawaban tidak selalu tersedia di rak koleksi, lab komputer menjadi ruang terbuka untuk menjelajah. Di sini, pengunjung dapat mengakses beragam sumber informasi melalui internet, menelusuri topik yang dibutuhkan, memperluas sudut pandang, dan menemukan referensi dalam berbagai bentuk—tidak hanya tulisan, tetapi juga visual dan audio digital lainnya.</p><p>Suasana yang nyaman dan fasilitas yang tersedia memberi kebebasan bagi pengunjung untuk belajar sesuai ritmenya sendiri. Proses mencari informasi menjadi pengalaman yang menyenangkan: mencoba, menemukan, dan mengelola pengetahuan secara mandiri. Dari sinilah literasi berubah menjadi keterampilan yang hidup dan relevan dengan kebutuhan masa kini.</p><p>Lab komputer di Graha Pusat Literasi hadir sebagai jembatan—menghubungkan pengetahuan dengan praktik, dan mengajak setiap pengunjung menjadi dari informasi ... sebuah lompatan awal untuk melangkah.</p>", img: "https://picsum.photos/seed/magetan1/1080/600" },
            { id: 2, title: "Lebih dari Sekedar Membaca", content: "<p>Isi artikel edukasi tentang budaya membaca di era digital.</p>", img: "https://picsum.photos/seed/magetan2/400/400" },
            { id: 3, title: "Menikmati Literasi Bersama", content: "<p>Ruang kolaborasi dan kreativitas anak muda Magetan.</p>", img: "https://picsum.photos/seed/magetan3/400/400" },
            { id: 4, title: "Dari Literasi ke Aksi", content: "<p>Penerapan ilmu pengetahuan ke dalam aksi pemberdayaan masyarakat.</p>", img: "https://picsum.photos/seed/magetan4/400/400" },
            { id: 5, title: "Belajar, Bereksperimen, Berbagi", content: "<p>Fasilitas modern pendukung minat baca masyarakat lokal.</p>", img: "https://picsum.photos/seed/magetan5/400/400" },
            { id: 6, title: "Literasi Berkembang Inovasi Dimulai", content: "<p>Bagaimana inovasi teknologi mendukung pelestarian arsip daerah.</p>", img: "https://picsum.photos/seed/magetan6/400/400" },
            { id: 7, title: "Literasi : Kisah dan Kasih", content: "<p>Catatan inspiratif komunitas penggerak literasi keliling.</p>", img: "https://picsum.photos/seed/magetan7/400/400" },
            { id: 8, title: "Literasi Hidup Disini", content: "<p>Graha Pusat Literasi sebagai rumah kedua bagi para pencari ilmu.</p>", img: "https://picsum.photos/seed/magetan8/400/400" },
            { id: 9, title: "Saat Pengetahuan Bertemu Teknologi", content: "<p>Pemanfaatan sistem digital terpadu dalam menelusuri sejarah Lawu.</p>", img: "https://picsum.photos/seed/magetan9/400/400" },
            { id: 10, title: "Dari Membaca Menuju Mencipta", content: "<p>Langkah nyata melahirkan generasi penulis baru dari Magetan.</p>", img: "https://picsum.photos/seed/magetan10/400/400" }
        </#if>
    ];

<#noparse>
    // 2. NAVIGASI INTERNAL (Sama Persis Seperti Sistem Koleksi Buku)
    function artNavigateTo(view) {
        document.getElementById('artViewBrowse').classList.toggle('hidden', view !== 'home');
        document.getElementById('artViewBrowse').classList.toggle('flex', view === 'home');
        document.getElementById('artViewDetail').classList.toggle('hidden', view !== 'detail');
        document.getElementById('artViewDetail').classList.toggle('flex', view === 'detail');
        
        if (view === 'home') {
            artRenderGrid();
        }
    }

    // 3. RENDER GRID MENU UTAMA BERITA (Otomatis Membagi Sesuai Aturan Tata Letak)
    function artRenderGrid() {
        const grid = document.getElementById('artGridContainer');
        if (!grid) return;

        grid.innerHTML = artDbArticles.map((item, index) => {
            // Tampilan Item Pertama sebagai Spanduk Besar Unggulan di atas Grid
            if (index === 0) {
                return `
                    <div onclick="artOpenDetail(${item.id})" class="col-span-3 block w-full bg-white/95 rounded-[30px] p-6 mb-4 shadow-md cursor-pointer transition-all duration-300 hover:-translate-y-2 text-center">
                        <img src="${item.img}" class="w-full h-[380px] object-cover rounded-[20px] mb-6 shadow-sm bg-slate-100">
                        <h2 class="font-['Gelasio'] text-[38px] font-bold text-slate-800 mb-3 leading-tight">${item.title}</h2>
                        <p class="font-['Lato'] text-[22px] text-slate-500">Klik untuk membaca cerita selengkapnya...</p>
                    </div>
                `;
            }
            // Sisa 9 Item di bawahnya disusun rapi menjadi struktur kotak 3x3
            return `
                <div onclick="artOpenDetail(${item.id})" class="flex flex-col items-center text-center cursor-pointer group transition-all duration-300 hover:-translate-y-2">
                    <div class="w-full aspect-square rounded-[20px] mb-4 overflow-hidden bg-slate-100 shadow-sm group-hover:shadow-md border border-white/60">
                        <img src="${item.img}" class="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105" onerror="this.src='https://placehold.co/400x400?text=Berita'">
                    </div>
                    <span class="font-['Lato'] text-[20px] font-bold text-slate-800 group-hover:text-[#3B5998] transition-colors leading-snug px-1">${item.title}</span>
                </div>
            `;
        }).join('');
    }

    // 4. AKSES OPERASI DETAIL (Menyalin isi Konten Secara Instan Tanpa Delay URL)
    function artOpenDetail(id) {
        const target = artDbArticles.find(x => x.id === id);
        if (!target) return;

        // Injeksi data artikel ke komponen visual Figma
        document.getElementById('artDtlTitle').innerText = target.title;
        document.getElementById('artDtlImg').src = target.img;
        document.getElementById('artDtlContent').innerHTML = target.content;
        document.getElementById('artDtlIdField').value = target.id;

        // Pindah layar ke menu detail view
        artNavigateTo('detail');
    }

    function artGoBack() {
        artNavigateTo('home');
    }

    // Inisialisasi Tampilan Saat Pertama Kali Dimuat
    setTimeout(() => artNavigateTo('home'), 100);
</#noparse>
</script>