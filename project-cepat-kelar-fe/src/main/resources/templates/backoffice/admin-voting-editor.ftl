<#assign activePage = "voting">
<#import "/layout/backoffice_layout.ftl" as layout>
<@layout.backofficeLayout title="Admin - Editor Voting" activePage=activePage adminName=adminName>

    <div class="w-full max-w-6xl mx-auto relative">      
      
      <div class="max-w-6xl w-full mx-auto px-4">
        <h2 class="text-3xl font-bold font-gelasio text-slate-800 italic">Manajemen Pemilihan</h2>
      </div>

      <!-- ASUMSI AUTO-DRAFT: ID Voting pasti sudah disediakan oleh Backend -->
      <#assign votingId = (voting.id)!0>

      <div class="w-full max-w-6xl mx-auto bg-white rounded-3xl shadow-lg border border-slate-100 p-8 mb-8 flex flex-col gap-8">
        
        <!-- ======================================================= -->
        <!-- FORM 1: INFO UTAMA (Hanya disubmit saat klik Publikasi) -->
        <!-- ======================================================= -->
        <form action="/admin/voting/save" method="POST" id="formVotingUtama">
            <input type="hidden" name="id" value="${votingId}">
            
            <div class="space-y-5">
                <h3 class="text-xl font-bold font-gelasio text-indigo-800 italic border-l-4 border-indigo-800 pl-3">Kegiatan Pemilihan</h3>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div class="md:col-span-2">
                        <input type="text" name="name" value="${(voting.name)!''}" placeholder="Nama Kegiatan Pemilihan" class="input-premium" required>
                    </div>
                    <div>
                        <label class="label-elegant">Tanggal Mulai</label>
                        <input type="date" name="startDate" value="${(voting.startDate)!''}" class="input-premium" required>
                    </div>
                    <div>
                        <label class="label-elegant">Tanggal Selesai</label>
                        <input type="date" name="endDate" value="${(voting.endDate)!''}" class="input-premium" required>
                    </div>
                </div>
            </div>
        </form>

        <hr class="border-slate-50">

        <!-- ======================================================= -->
        <!-- FORM 2: TAMBAH KANDIDAT (Langsung submit ke Database)   -->
        <!-- ======================================================= -->
        <form action="/admin/voting/entry/save" method="POST" class="flex flex-col lg:flex-row gap-10">
            <!-- Tali pengikat otomatis ke Acara Utama -->
            <input type="hidden" name="votingId" value="${votingId}">
            
            <div class="lg:w-56 flex flex-col items-center gap-3">
                <label class="label-elegant">Unggah foto / Poster Kandidat</label>
                <div class="w-52 h-52 bg-slate-50 border-2 border-dashed border-slate-200 rounded-2xl flex items-center justify-center cursor-pointer hover:bg-white transition-all group shadow-sm relative overflow-hidden">
                    <img id="kandidatPreviewImage" src="" class="w-full h-full object-cover hidden">
                    <div id="kandidatPlaceholderImage" class="text-center p-4">
                        <span class="block text-2xl mb-1 group-hover:scale-110 transition">Image</span>
                        <span class="text-indigo-800 font-bold font-lato text-xs">Unggah Gambar</span>
                    </div>
                    <input type="file" id="kandidatFileInput" class="absolute inset-0 opacity-0 cursor-pointer" accept="image/*">
                    <!-- Teks Base64 foto dikirim lewat input ini -->
                    <input type="hidden" name="entryPhotoBase64" id="kandidatFotoBase64">
                </div>
            </div>

            <div class="flex-1 space-y-5">
                <div>
                    <label class="label-elegant">Judul (Nama Kandidat/Opsi)</label>
                    <input type="text" name="entryName" placeholder="Contoh: Andi atau Buku Fiksi" class="input-premium" required>
                </div>
                <div>
                    <label class="label-elegant">Keterangan singkat</label>
                    <textarea name="entrySummary" placeholder="Deskripsi Singkat / Informasi Visi Misi" class="input-premium w-full h-28 resize-none py-3" required></textarea>
                    
                    <div class="flex justify-end mt-5 mb-2">
                        <!-- Murni tombol submit HTML, langsung reload halaman dan simpan! -->
                        <button type="submit" class="bg-[#bef264] hover:bg-lime-400 text-indigo-900 font-bold px-6 py-2 rounded-xl shadow-md transition-all active:scale-95 text-sm font-lato">
                            + Tambah Entri Pemilihan
                        </button>
                    </div>
                </div>
            </div>
        </form>

        <hr class="border-slate-50">

        <!-- ======================================================= -->
        <!-- TABEL KANDIDAT (Memanggil data dari Backend)            -->
        <!-- ======================================================= -->
        <div class="space-y-5">
            <div class="flex justify-between items-center">
                <h3 class="text-xl font-bold font-gelasio text-indigo-800 italic border-l-4 border-indigo-800 pl-3">Daftar item poin pemilihan</h3>
            </div>
            
            <div class="border border-slate-100 rounded-2xl overflow-hidden shadow-sm">
                <table class="table-custom font-lato w-full text-left">
                    <thead class="bg-slate-50 text-black font-bold">
                        <tr>
                            <th class="w-24 p-4">Gambar</th>
                            <th class="p-4">Item Opsi Pemilihan</th>
                            <th class="p-4">Deskripsi Singkat</th>
                            <th class="w-32 p-4 text-center">Aksi</th>
                        </tr>
                    </thead>
                    <tbody class="text-slate-700">
                        <!-- Data ini ditarik langsung oleh FreeMarker dari Database Java -->
                        <#if votingEntries?? && votingEntries?size > 0>
                            <#list votingEntries as entry>
                            <tr class="border-t border-slate-100">
                                <td class="p-4">
                                    <div class="w-12 h-12 bg-slate-200 rounded-lg mx-auto overflow-hidden">
                                        <#if entry.imageUrl?? && entry.imageUrl?has_content>
                                            <img src="${entry.imageUrl}" class="w-full h-full object-cover">
                                        <#else>
                                            <div class="w-full h-full bg-slate-200 flex items-center justify-center text-slate-400 text-xs">No Img</div>
                                        </#if>
                                    </div>
                                </td>
                                <td class="font-bold text-black p-4">${entry.name}</td>
                                <td class="text-sm p-4">${entry.summary}</td>
                                <td class="p-4 text-center">
                                    <!-- FORM 3: HAPUS KANDIDAT -->
                                    <form action="/admin/voting/entry/delete/${entry.id}" method="POST" onsubmit="return confirm('Hapus kandidat ini?');">
                                        <input type="hidden" name="votingId" value="${votingId}">
                                        <button type="submit" class="hover:scale-110 transition text-red-500 font-bold text-sm cursor-pointer">
                                            Delete
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            </#list>
                        <#else>
                            <tr id="rowKosong">
                                <td colspan="4" class="py-6 text-slate-400 italic text-center">Belum ada entri pilihan. Isi form di atas lalu klik Tambah.</td>
                            </tr>
                        </#if>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- ======================================================= -->
        <!-- TOMBOL PUBLIKASI UNTUK FORM UTAMA (Memanggil Form 1)    -->
        <!-- ======================================================= -->
        <div class="flex justify-center pt-6 border-t border-slate-50">
            <!-- Tombol ini berfungsi memicu id="formVotingUtama" di atas -->
            <button type="button" onclick="document.getElementById('formVotingUtama').submit();" class="bg-[#bef264] hover:bg-lime-400 text-indigo-900 font-bold px-24 py-4 rounded-2xl shadow-lg transition-all active:scale-95 text-xl font-lato">
                Publikasikan Pemilihan
            </button>
        </div>

      </div> 

      <!-- SCRIPT SUPER PENDEK (Hanya untuk preview gambar kandidat sebelum disubmit) -->
      <script>
        document.addEventListener('DOMContentLoaded', function() {
            const fileInput = document.getElementById('kandidatFileInput');
            const preview = document.getElementById('kandidatPreviewImage');
            const placeholder = document.getElementById('kandidatPlaceholderImage');
            const base64Input = document.getElementById('kandidatFotoBase64');
            
            if (fileInput) {
                fileInput.addEventListener('change', function() {
                    const file = this.files[0];
                    if (!file) return;

                    preview.src = URL.createObjectURL(file);
                    preview.classList.remove('hidden');
                    placeholder.classList.add('hidden');

                    const reader = new FileReader();
                    reader.onload = function(e) {
                        base64Input.value = e.target.result;
                    };
                    reader.readAsDataURL(file);
                });
            }
        });
      </script>

    </div>

</@layout.backofficeLayout>