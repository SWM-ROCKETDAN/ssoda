package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.app.dto.store.StoreResponseDto;
import com.rocketdan.serviceserver.app.dto.store.StoreSaveRequestDto;
import com.rocketdan.serviceserver.service.StoreService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
public class StoreApiController {
    private final StoreService storeService;

//    @GetMapping("/api/v1/stores")
//    public List<StoreListRequestDto> retrieveAllStores() {
//        return storeService.findAll();
//    }

//    @GetMapping("/api/v1/stores")
//    public StoreListResponseDto retrieveStoreList() {
//        return storeService.findListById();
//    }

    @GetMapping("/api/v1/stores/{id}")
    public StoreResponseDto findById(@PathVariable Long id) {
        return storeService.findById(id);
    }

    @PostMapping("/api/v1/stores")
    public Long save(@RequestBody StoreSaveRequestDto store) {
        return storeService.save(store);
    }

//    @PutMapping("/api/v1/store/{id}")
//    public Long update(@PathVariable Long id, @RequestBody StoreUpdateRequestDto requestDto) {
//        return storeService.update(id, requestDto);
//    }

//    @DeleteMapping("/api/v1/store/{id}")
//    public void delete(@PathVariable Long id) {
//        storeService.delete(id);
//    }
}
