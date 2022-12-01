

function xic_shen_template(degree,name,output)
   
    mask_path = '/home1/xic_fdu/project/IAMGEN_Develop_diagnostic_0814/Trans_diagnostic_p_facotr/NII_brain_results/shen_268_617361_grey_mask_new.nii';           
    out_path = fullfile(output,name);
    mask = load_nii(mask_path);
    mask_dat = mask.img;
    
    for i=1:268
        mask_dat(mask_dat==i) = degree(i);
    end
    mask.img = mask_dat;
    
    save_nii(mask,out_path);
    
end
