<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detail Audio - ${audio.title}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Gelasio:wght@700&family=Lato:wght@400&family=Inter:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { background-color: #1a1a1a; margin: 0; display: flex; justify-content: center; align-items: flex-start; height: 100vh; overflow: hidden; }
        .HasilAudio { 
            width: 864px; height: 1536px; background-color: #f7f0cb; 
            position: relative; overflow: hidden; transform-origin: top center; 
        }
        .Frame51 {
            width: 764px; height: 1149px; left: 50px; top: 240px; position: absolute;
            background: white; border-radius: 24px; box-shadow: 0 20px 50px rgba(0,0,0,0.1);
            overflow-y: auto; scrollbar-width: none;
        }
        .Frame51::-webkit-scrollbar { display: none; }
        .content-wrapper { position: relative; width: 100%; height: 1300px; }
        .PlayerModule { 
            width: 650px; height: 160px; left: 57px; top: 350px; position: absolute; 
            background: #f8fafc; border-radius: 20px; border: 1px solid #e2e8f0;
            display: flex; flex-direction: column; justify-content: center; padding: 0 35px; gap: 15px;
        }
        .bar-bg { width: 100%; height: 10px; background: #e2e8f0; border-radius: 10px; position: relative; cursor: pointer; }
        .bar-fill { height: 100%; background: #3730a3; border-radius: 10px; width: 0%; transition: width 0.1s linear; }
        .spinning { 
            border-radius: 50% !important; border: 8px solid #333 !important;
            animation: rotate-vinyl 8s linear infinite; box-shadow: 0 0 30px rgba(0,0,0,0.3);
        }
        @keyframes rotate-vinyl { from { transform: rotate(0deg); } to { transform: rotate(360deg); } }
    </style>
</head>
<body>

    <audio id="audioEngine" src="${audio.filePath}"></audio>

    <div id="kios-canvas" class="HasilAudio">
        <div class="absolute right-[45px] top-[30px] text-5xl cursor-pointer font-bold" onclick="location.reload()">x</div>
        
        <div class="absolute left-0 right-0 top-[140px] text-center text-sky-400 text-xl font-['Lato'] cursor-pointer" onclick="window.history.back()">
            &lt; Kembali ke daftar audio
        </div>

        <div class="Frame51">
            <div class="content-wrapper">
                
                <div class="Frame63 w-[700px] h-80 left-[30px] top-[30px] absolute bg-white overflow-hidden">
                    <img src="${audio.coverUrl!'rekaman.jpeg'}" id="albumArt" class="Rectangle31 w-72 h-72 left-[-9px] top-[13.50px] absolute rounded-2xl object-cover bg-zinc-300">
                    <div class="w-80 left-[352.84px] top-[50px] absolute text-center text-black text-4xl font-bold font-['Gelasio'] leading-tight">${audio.title}</div>
                    <div class="w-60 left-[394.54px] top-[125px] absolute text-center text-black text-4xl font-bold font-['Gelasio']">${audio.callNumber}</div>
                    <div class="w-56 left-[454.29px] top-[195px] absolute text-black text-3xl font-bold font-['Gelasio'] opacity-60 uppercase">${audio.category}</div>
                </div>

                <div class="PlayerModule">
                    <div class="flex justify-between items-center text-xl font-bold font-['Inter']">
                        <span id="curTime">00:00</span>
                        <div class="bar-bg" onclick="seekAudio(event)"><div id="fill" class="bar-fill"></div></div>
                        <span id="totalDur">00:00</span>
                    </div>
                    <div class="flex justify-center items-center gap-14">
                        <i class="fas fa-undo text-4xl text-slate-300 cursor-pointer" onclick="jump(-10)"></i>
                        <i id="playBtn" class="fas fa-play text-8xl text-indigo-800 cursor-pointer" onclick="togglePlay()"></i>
                        <i class="fas fa-redo text-4xl text-slate-300 cursor-pointer" onclick="jump(10)"></i>
                    </div>
                </div>

                <div class="Frame62 w-[730px] h-[639px] left-[19px] top-[560px] absolute bg-white overflow-hidden">
                    <div class="Keterangan left-[57px] top-[10px] absolute text-black text-4xl font-bold font-['Gelasio']">Keterangan</div>
                    
                    <div class="Rectangle34 w-[650px] h-32 left-[23px] top-[80px] absolute bg-white rounded-2xl shadow-[0px_4px_10px_rgba(0,0,0,0.1)]"></div>
                    <div class="absolute left-[53px] top-[95px] text-black text-2xl font-bold font-['Gelasio'] opacity-40">Pengisi suara / Pencipta</div>
                    <div class="absolute left-[53px] top-[135px] text-black text-3xl font-bold font-['Gelasio']">${audio.author}</div>

                    <div class="Rectangle32 w-[650px] h-32 left-[23px] top-[230px] absolute bg-white rounded-2xl shadow-[0px_4px_10px_rgba(0,0,0,0.1)]"></div>
                    <div class="absolute left-[53px] top-[240px] text-black text-2xl font-bold font-['Gelasio'] opacity-40">Data Penerbit</div>
                    <div class="absolute left-[53px] top-[280px] text-black text-3xl font-bold font-['Gelasio']">${audio.publisher}</div>

                    <div class="Rectangle33 w-[650px] h-32 left-[27px] top-[390px] absolute bg-white rounded-2xl shadow-[0px_4px_10px_rgba(0,0,0,0.1)]"></div>
                    <div class="absolute left-[43px] top-[400px] text-black text-2xl font-bold font-['Gelasio'] opacity-40">Data Fisik</div>
                    <div class="flex justify-between w-[580px] left-[43px] top-[440px] absolute text-black text-3xl font-bold font-['Gelasio']">
                        <span>${audio.duration}</span> <span>${audio.format}</span> <span>${audio.recordCount} rekaman</span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function applyScaling() {
            const canvas = document.getElementById('kios-canvas');
            canvas.style.transform = `scale(${(window.innerHeight - 10) / 1536})`;
        }
        const audio = document.getElementById('audioEngine');
        const playBtn = document.getElementById('playBtn');
        const fill = document.getElementById('fill');
        const art = document.getElementById('albumArt');

        function togglePlay() {
            if (audio.paused) {
                audio.play(); playBtn.classList.replace('fa-play', 'fa-pause'); art.classList.add('spinning');
            } else {
                audio.pause(); playBtn.classList.replace('fa-pause', 'fa-play'); art.classList.remove('spinning');
            }
        }
        function jump(s) { audio.currentTime += s; }
        function seekAudio(e) {
            const rect = e.currentTarget.getBoundingClientRect();
            audio.currentTime = ((e.clientX - rect.left) / rect.width) * audio.duration;
        }
        audio.addEventListener('timeupdate', () => {
            fill.style.width = (audio.currentTime / audio.duration) * 100 + "%";
            document.getElementById('curTime').innerText = fmt(audio.currentTime);
            if(!isNaN(audio.duration)) document.getElementById('totalDur').innerText = fmt(audio.duration);
        });
        function fmt(s) {
            let m=Math.floor(s/60), sc=Math.floor(s%60);
            return (m<10?"0"+m:m)+":"+(sc<10?"0"+sc:sc);
        }
        window.addEventListener('load', applyScaling);
        window.addEventListener('resize', applyScaling);
    </script>
</body>
</html>