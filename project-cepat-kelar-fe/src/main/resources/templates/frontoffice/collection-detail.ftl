<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>${book.title!"Detail Koleksi"} - Graha Pusat Literasi</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Gelasio:wght@700&family=Lato:wght@400;700&family=Inter:wght@400&display=swap" rel="stylesheet">
    
    <style>
        body { 
            background-color: #1a1a1a; margin: 0; padding: 0; 
            height: 100vh; width: 100vw; overflow: hidden; 
            display: flex; justify-content: center; align-items: center; 
        }

        /* KANVAS UTAMA: 864x1536px */
        #koleksi-canvas {
            width: 864px; height: 1536px;
            background-color: #f7f0cb; 
            position: relative; overflow: hidden;
            box-shadow: 0 0 100px rgba(0,0,0,0.5);
            transform-origin: center center;
        }

        /* GATEWAY: Tombol X Pojok Kanan Atas */
        .close-btn {
            position: absolute; top: 30px; right: 45px;
            font-size: 50px; color: black; cursor: pointer; z-index: 100; 
            font-family: 'Inter', sans-serif;
        }

        /* LINK NAVIGASI */
        .back-link {
            position: absolute; top: 136px; left: 0; width: 100%; text-align: center;
            color: #7dd3fc; font-family: 'Lato', sans-serif; font-size: 18px; 
            cursor: pointer; text-decoration: none;
        }

        /* KARTU PUTIH (FRAME 51) */
        .white-card {
            position: absolute; top: 220px; left: 50px;
            width: 764px; height: 1149px;
            background: white; border-radius: 16px;
            display: flex; flex-direction: column; padding: 50px;
        }

        .header-info { display: flex; gap: 40px; margin-bottom: 60px; }
        .cover-box { width: 240px; height: 320px; flex-shrink: 0; border-radius: 8px; overflow: hidden; box-shadow: 0 8px 20px rgba(0,0,0,0.1); }
        .cover-img { width: 100%; height: 100%; object-fit: cover; }
        
        .meta-data { flex: 1; text-align: center; display: flex; flex-direction: column; justify-content: center; gap: 20px; }

        /* KOTAK KETERANGAN TIMBUL */
        .info-box {
            background: white; border-radius: 16px; padding: 25px; margin-bottom: 25px;
            box-shadow: 0px 4px 15px rgba(0,0,0,0.08); text-align: center;
            border: 1px solid #f1f5f9;
        }

        .label-text { font-family: 'Gelasio', serif; font-weight: bold; font-size: 32px; color: black; margin-bottom: 8px; }
        .value-text { font-family: 'Gelasio', serif; font-weight: bold; font-size: 32px; color: black; }
    </style>
</head>
<body>

    <div id="koleksi-canvas">
        <#-- GATEWAY 1: TOMBOL X -->
        <div class="close-btn" onclick="window.history.back()">X</div>

        <#-- GATEWAY 2: LINK KEMBALI -->
        <a href="javascript:void(0)" onclick="window.history.back()" class="back-link">&lt; Kembali ke daftar audio</a>

        <div class="white-card">
            <#-- INFO HEADER -->
            <div class="header-info">
                <div class="cover-box">
                    <img class="cover-img" src="${book.cover!"/images/frontoffice/baris1.png"}" alt="${book.title!"Cover"}">
                </div>
                <div class="meta-data">
                    <h1 class="font-['Gelasio'] font-bold text-2xl leading-tight">
                        ${book.title!"Para Penyala cahaya dari Lereng Gunung Lawu"}
                    </h1>
                    <div class="font-['Gelasio'] font-bold text-5xl mt-2 text-black">
                        ${book.callNumber!"899.221"}
                    </div>
                    <div class="font-['Gelasio'] font-bold text-4xl text-black">
                        ${book.category!"Novel"}
                    </div>
                </div>
            </div>

            <#-- KETERANGAN DATA -->
            <div class="mt-4">
                <h2 class="font-['Gelasio'] font-bold text-4xl mb-10 ml-4">Keterangan</h2>
                
                <div class="info-box">
                    <div class="label-text">Tajuk Pengarang</div>
                    <div class="value-text">${book.author!"Mage Tan"}</div>
                </div>

                <div class="info-box">
                    <div class="label-text">Data Penerbit</div>
                    <div class="value-text">${book.publisher!"Indonesia : Karya, 2019"}</div>
                </div>

                <div class="info-box">
                    <div class="label-text">Data Fisik</div>
                    <div class="value-text">${book.physicalData!"i, 300 hal. 24 cm"}</div>
                </div>
            </div>
        </div>
    </div>

    <script>
        <#-- FUNGSI SCALING: AGAR 1536px MUAT DI MONITOR ANDA -->
        function scaleCanvas() {
            const canvas = document.getElementById('koleksi-canvas');
            const windowHeight = window.innerHeight - 40; 
            const scale = windowHeight / 1536; 
            canvas.style.transform = "scale(" + scale + ")";
        }
        window.addEventListener('load', scaleCanvas);
        window.addEventListener('resize', scaleCanvas);
    </script>
</body>
</html>