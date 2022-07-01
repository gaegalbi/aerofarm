package yj.capstone.aerofarm.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import yj.capstone.aerofarm.repository.DeviceRepository;

@Service
@RequiredArgsConstructor
public class DeviceService {
    private final DeviceRepository deviceRepository;


}
