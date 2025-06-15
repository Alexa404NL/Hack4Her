const elVideo = document.getElementById('video');

navigator.getMedia = (navigator.getUserMedia ||
                    navigator.webkitGetUserMedia || navigator.mozGetUserMedia)

Promise.all([
  faceapi.nets.ageGenderNet.loadFromUri('/face-api/models'),
  faceapi.nets.faceExpressionNet.loadFromUri('/face-api/models'),
  faceapi.nets.faceLandmark68Net.loadFromUri('/face-api/models'),
  faceapi.nets.faceLandmark68TinyNet.loadFromUri('/face-api/models'),
  faceapi.nets.faceRecognitionNet.loadFromUri('/face-api/models'),
  faceapi.nets.ssdMobilenetv1.loadFromUri('/face-api/models'),
   faceapi.nets.tinyFaceDetector.loadFromUri('/face-api/models')

  
]).then(cargarCamera);

const cargarCamera = async () => {
  navigator.getMedia (
    {
      video: true,
      audio: false
    },
    stream => elVideo.srcObject = stream,
      console.error
    
  )
};


elVideo.addEventListener('play', async () => {
  const canvas = faceapi.createCanvasFromMedia(elVideo)
  document.body.append(canvas)

  /* setInterval(async () => {
    const detections = await faceapi.nets.detectAllFaces(elVideo, new faceapi.nets.TinyFaceDetectorOptions())
      .withFaceLandmarks()
      .withFaceExpressions()
      .withAgeAndGender();

    const resized = faceapi.nets.resizeResults(detections, displaySize);

    canvas.getContext('2d').clearRect(0, 0, canvas.width, canvas.height);

    faceapi.nets.draw.drawDetections(canvas, resized);
    faceapi.nets.draw.drawFaceLandmarks(canvas, resized);
    faceapi.nets.draw.drawFaceExpressions(canvas, resized);

    resized.forEach(det => {
      const { age, gender, detection } = det;
      new faceapi.nets.draw.DrawBox(detection.box, {
        label: `${Math.round(age)} años, ${gender}`
      }).draw(canvas);
    });
  }, 100); */
});





