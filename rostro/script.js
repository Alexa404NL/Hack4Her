const elVideo = document.getElementById('video');

const cargarCamera = async () => {
  try {
    const stream = await navigator.mediaDevices.getUserMedia({ video: true, audio: false });
    elVideo.srcObject = stream;
  } catch (err) {
    console.error("No se pudo acceder a la cámara:", err);
  }
};

Promise.all([
  faceapi.nets.tinyFaceDetector.loadFromUri('/models'),
  faceapi.nets.faceLandmark68Net.loadFromUri('/models'),
  faceapi.nets.faceRecognitionNet.loadFromUri('/models'),
  faceapi.nets.faceExpressionNet.loadFromUri('/models'),
  faceapi.nets.ageGenderNet.loadFromUri('/models'),
]).then(cargarCamera);

elVideo.addEventListener('play', async () => {
  const canvas = faceapi.createCanvasFromMedia(elVideo);
  document.body.append(canvas);

  const displaySize = { width: elVideo.width, height: elVideo.height };
  faceapi.matchDimensions(canvas, displaySize);

  setInterval(async () => {
    const detections = await faceapi.detectAllFaces(elVideo, new faceapi.TinyFaceDetectorOptions())
      .withFaceLandmarks()
      .withFaceExpressions()
      .withAgeAndGender();

    const resized = faceapi.resizeResults(detections, displaySize);

    canvas.getContext('2d').clearRect(0, 0, canvas.width, canvas.height);

    faceapi.draw.drawDetections(canvas, resized);
    faceapi.draw.drawFaceLandmarks(canvas, resized);
    faceapi.draw.drawFaceExpressions(canvas, resized);

    resized.forEach(det => {
      const { age, gender, detection } = det;
      new faceapi.draw.DrawBox(detection.box, {
        label: `${Math.round(age)} años, ${gender}`
      }).draw(canvas);
    });
  }, 100);
});





