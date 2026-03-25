<#-- FRAGMENT HIGHLIGHTS.FTL (DESAIN KLASIK & LOGIKA DATABASE MAX 3 ITEM) -->
<#-- PENTING: Jangan tambahkan <html>, <head>, atau <body> di sini -->

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<style>
    /* --- Animasi & Styling FAQ Gaya Klasik --- */
    .faq-row {
        background-color: rgba(255, 255, 255, 0.45); 
        backdrop-filter: blur(4px);
        transition: background-color 0.3s ease;
        position: relative;
    }
    .faq-row:hover { 
        background-color: rgba(255, 255, 255, 0.65); 
    }
    
    /* Ikon Plus Putar */
    .faq-icon-plus {
        position: absolute;
        left: 40px;
        font-family: monospace;
        font-size: 32px;
        font-weight: bold;
        color: #334155;
        transition: transform 0.3s ease;
        line-height: 1;
    }
    .faq-row.active .faq-icon-plus { 
        transform: rotate(45deg); /* Berubah jadi X saat dibuka */
    }

    /* Transisi Buka Tutup Konten */
    .faq-body { 
        display: grid; 
        grid-template-rows: 0fr; 
        transition: grid-template-rows 0.4s ease; 
    }
    .faq-row.active + .faq-body { 
        grid-template-rows: 1fr; 
        margin-bottom: 30px; 
    }
    .faq-content { overflow: hidden; }
</style>

<div class="relative min-h-full -mx-[50px] -my-[50px] px-[50px] py-[70px] flex flex-col">
    
    <div class="absolute inset-0 z-0 pointer-events-none opacity-30 mix-blend-multiply" 
         style="background-image: url('${batikPath!"/images/frontoffice/batikspring.png"}'); background-size: 400px; background-repeat: repeat;">
    </div>

    <div class="relative z-10 flex flex-col flex-grow w-full max-w-4xl mx-auto">
        
        <div class="text-center mb-16 mt-8">
            <h2 class="text-[54px] font-bold text-[#475569] font-['Gelasio'] mb-8 tracking-wide">
                ${mainTitle!"Highlights"}
            </h2>
            <p class="text-[22px] text-[#475569] font-['Gelasio'] font-bold max-w-3xl mx-auto leading-[1.8]">
                ${subTitle!"Pertanyaanmu penting, dan kami siap menjawab pertanyaan mu disini. Semua yang ingin kamu ketahui kami rangkum dalam satu tempat. Temukan jawaban atas pertanyaan yang paling sering ditanyakan disini."}
            </p>
        </div>

        <div class="flex-grow w-full flex flex-col gap-6">
            
            <#-- LOGIKA DATABASE MENGGUNAKAN FREEMARKER -->
            <#if faqs?? && faqs?has_content>
                
                <#-- Looping data asli dari database -->
                <#list faqs as faq>
                    <#-- MENGUNCI MAKSIMAL 3 ITEM (Index 0, 1, 2) -->
                    <#if faq?index == 3><#break></#if> 

                    <div>
                        <div class="faq-row py-6 px-8 flex items-center cursor-pointer shadow-sm" onclick="this.classList.toggle('active')">
                            <span class="faq-icon-plus">+</span>
                            <h3 class="w-full text-center font-['Gelasio'] text-[24px] font-bold text-[#334155] pr-[40px]">
                                ${faq.question}
                            </h3>
                        </div>
                        <div class="faq-body">
                            <div class="faq-content">
                                <div class="px-16 py-6 text-center">
                                    <p class="text-[#475569] text-[20px] font-['Lato'] font-medium leading-relaxed italic">
                                        ${faq.answer}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </#list>

            <#else>
                <#-- DATA DUMMY (Tampil jika belum ada koneksi ke database) -->
                
                <div>
                    <div class="faq-row py-6 px-8 flex items-center cursor-pointer shadow-sm" onclick="this.classList.toggle('active')">
                        <span class="faq-icon-plus">+</span>
                        <h3 class="w-full text-center font-['Gelasio'] text-[24px] font-bold text-[#334155] pr-[40px]">
                            Bagaimana cara menjadi anggota perpustakaan?
                        </h3>
                    </div>
                    <div class="faq-body">
                        <div class="faq-content">
                            <div class="px-16 py-6 text-center">
                                <p class="text-[#475569] text-[20px] font-['Lato'] font-medium leading-relaxed italic">
                                    Pendaftaran sangat mudah dan gratis. Anda hanya perlu datang ke meja resepsionis di Lantai 1 dengan membawa KTP, KIA, atau Kartu Pelajar. Prosesnya hanya memakan waktu 10 menit.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <div>
                    <div class="faq-row py-6 px-8 flex items-center cursor-pointer shadow-sm" onclick="this.classList.toggle('active')">
                        <span class="faq-icon-plus">+</span>
                        <h3 class="w-full text-center font-['Gelasio'] text-[24px] font-bold text-[#334155] pr-[40px]">
                            Bagaimana cara mengajukan kegiatan kunjungan bersama?
                        </h3>
                    </div>
                    <div class="faq-body">
                        <div class="faq-content">
                            <div class="px-16 py-6 text-center">
                                <p class="text-[#475569] text-[20px] font-['Lato'] font-medium leading-relaxed italic">
                                    Sekolah atau instansi dapat mengirimkan surat permohonan kunjungan ke email resmi kami atau menyerahkannya langsung ke petugas resepsionis minimal 3 hari sebelum jadwal kunjungan.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <div>
                    <div class="faq-row py-6 px-8 flex items-center cursor-pointer shadow-sm" onclick="this.classList.toggle('active')">
                        <span class="faq-icon-plus">+</span>
                        <h3 class="w-full text-center font-['Gelasio'] text-[24px] font-bold text-[#334155] pr-[40px]">
                            Apa saja fasilitas dan layanan yang disediakan di Graha Pusat Literasi?
                        </h3>
                    </div>
                    <div class="faq-body">
                        <div class="faq-content">
                            <div class="px-16 py-6 text-center">
                                <p class="text-[#475569] text-[20px] font-['Lato'] font-medium leading-relaxed italic">
                                    Kami menyediakan area baca yang nyaman, akses Wi-Fi gratis, Soundproof Pod untuk audiobook, ruang koleksi khusus Sejarah Magetan, serta Kotak Suara untuk menyalurkan aspirasi literasi Anda.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </#if>
        </div>

        <div class="mt-16 text-center pb-8">
            <p class="text-[22px] font-bold text-[#475569] font-['Gelasio'] max-w-2xl mx-auto leading-relaxed mb-10">
                ${footerDesc!"Masih belum menemukan jawaban yang kamu suka? atau kamu memrlukan informasi tambahan? Jangan khawatir kamu bisa menghubungi kami langsung lewat sini:"}
            </p>
            <div class="flex justify-center gap-10">
                <a href="${whatsappLink!"#"}" class="w-[70px] h-[70px] rounded-full border-2 border-[#475569] flex items-center justify-center text-[#475569] hover:bg-[#25D366] hover:text-white hover:border-[#25D366] transition-all">
                    <i class="fab fa-whatsapp text-4xl"></i>
                </a>
                <a href="${instagramLink!"#"}" class="w-[70px] h-[70px] rounded-full border-2 border-[#475569] flex items-center justify-center text-[#475569] hover:bg-[#E1306C] hover:text-white hover:border-[#E1306C] transition-all">
                    <i class="fab fa-instagram text-4xl"></i>
                </a>
            </div>
        </div>

    </div>
</div>