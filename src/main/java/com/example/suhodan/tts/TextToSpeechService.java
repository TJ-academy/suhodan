package com.example.suhodan.tts;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;

import org.springframework.stereotype.Service;

import com.google.cloud.texttospeech.v1beta1.AudioConfig;
import com.google.cloud.texttospeech.v1beta1.AudioEncoding;
import com.google.cloud.texttospeech.v1beta1.SsmlVoiceGender;
import com.google.cloud.texttospeech.v1beta1.SynthesisInput;
import com.google.cloud.texttospeech.v1beta1.SynthesizeSpeechResponse;
import com.google.cloud.texttospeech.v1beta1.TextToSpeechClient;
import com.google.cloud.texttospeech.v1beta1.VoiceSelectionParams;
import com.google.protobuf.ByteString;

@Service
public class TextToSpeechService {

    public void generateSpeech(String text, String filename, String path) throws Exception {
        // 파일명에 .mp3 확장자가 없으면 추가
        if (!filename.endsWith(".mp3")) {
            filename += ".mp3";
        }

        try (TextToSpeechClient textToSpeechClient = TextToSpeechClient.create()) {

            SynthesisInput input = SynthesisInput.newBuilder().setText(text).build();

            VoiceSelectionParams voice = VoiceSelectionParams.newBuilder()
                    .setLanguageCode("ko-KR")
                    .setSsmlGender(SsmlVoiceGender.FEMALE)
                    .build();

            AudioConfig audioConfig = AudioConfig.newBuilder()
                    .setAudioEncoding(AudioEncoding.MP3)
                    .build();

            SynthesizeSpeechResponse response = textToSpeechClient.synthesizeSpeech(input, voice, audioConfig);
            ByteString audioContents = response.getAudioContent();

            File dir = new File(path);
            if (!dir.exists()) dir.mkdirs();  // 디렉토리가 없으면 생성

            try (OutputStream out = new FileOutputStream(path + File.separator + filename)) {
                out.write(audioContents.toByteArray());
            }

            System.out.println("저장 완료: " + path + filename);
        }
    }
}
