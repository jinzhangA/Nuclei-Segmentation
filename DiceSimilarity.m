function sim = DiceSimilarity(phi_Alg, phi_GT)
% Compute Dice for two cells
    Voxel_idx_Alg = find(phi_Alg == 1);
    Voxel_idx_GT = find(phi_GT == 1);
    
    % Phi_1 intersect Phi_2
    Alg_and_GT = intersect(Voxel_idx_Alg, Voxel_idx_GT);
    num_Alg_and_GT = size(Alg_and_GT,1);
    
    % Pixel Number of phi_Alg and phi_GT, respectively.
    num_Alg = size(Voxel_idx_Alg,1);
    num_GT = size(Voxel_idx_GT,1);
    
    sim = (2 * num_Alg_and_GT) / (num_Alg + num_GT);
end