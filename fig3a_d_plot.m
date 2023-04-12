%% Plot Fig 3A-D from Dewey and Shera (2023) JARO
close all;clear;clc;
load Dewey_2023_JARO_figs.mat

panels = [{'a'};{'b'};{'c'};{'d'}]; % panel letters
panelN = length(panels);

% Plot data for each panel
for p_i = 1:panelN
    p = panels{p_i};
    switch p
        case 'a'  
            %% Fig. 3A - Single-tone BM responses and DPOAEs for 50 dB SPL stimuli for mouse 'm101'
            locs = [{'BM'};{'EC'}]; % locations
            clrs = [{[28 82 172]/255}; {'r'}]; % location colors
       
            % Set up figure
            h=figure('units','normalized','position',[.05 .2 .22 .3]);
            ax1 = axes('position',[.15 .15 .7 .75], 'box', 'off','LineWidth',1.4, 'FontSize',15); hold on;
            
            xlim([2 14]); set(gca,'Xscale','log','Xtick',[1 2 5 10 20 50]);
            ax1.XAxis.TickLength = [0.01 0.01];
            
            ylim([-42.5 5]); set(gca,'Ytick',-100:20:100);
            ax1.YAxis.MinorTick = 'on';
            ax1.YAxis.MinorTickValues = -100:10:100;
            ax1.YAxis.TickLength = [0.02 0.02];
            
            % Plot data for each location
            for loc_i = 1:length(locs)
                loc = locs{loc_i}; % location
                clr = clrs{loc_i}; % color
            
                switch loc
                    case 'BM'
                        f = fig3.a.BM.f1s; % stimulus frequency (Hz)
                        mag = 20*log10(fig3.a.BM.vib.f1.mag); % displacement magnitude (dB re 1 nm)
                        magC = 20*log10(fig3.a.BM.vib.f1.magC); % clean displacement magnitude
                        [mag_max,max_i] = max(magC); % find max displacement
                    
                        % Plot
                        plot(f/1000, mag - mag_max, ':', 'LineWidth',1.8, 'Color', clr);
                        plot(f/1000, magC - mag_max, '-', 'LineWidth',3.5, 'Color', clr);
                        plot(f(max_i)/1000,0, 'o', 'LineWidth',1.5, 'Color', clr, 'MarkerFaceColor','w','MarkerSize', 8);
     
                    case 'EC'                    
                        f = 2*fig3.a.EC.f1s - fig3.a.EC.f2s; % DP frequency (Hz)
                        mag = 20*log10(fig3.a.EC.mic.dp.mag/2e-5); % DPOAE amplitude (dB SPL)
                        magC = 20*log10(fig3.a.EC.mic.dp.magC/2e-5); % Clean DPOAE amplitude
                        [mag_max,max_i] = max(magC); % find max DPOAE amplitude

                        % Plot
                        plot(f/1000, mag - mag_max, ':','LineWidth',1.8,'Color', clr);
                        plot(f/1000, magC - mag_max, '-', 'LineWidth',3.5, 'Color', clr);
                        plot(f(max_i)/1000, 0, 'o', 'LineWidth',1.5, 'Color', clr, 'MarkerFaceColor','w','MarkerSize', 8);
                end
            end
    
        case 'b' 
            %% Fig. 3B - Q10dB vs. stimulus level for 'm101'
            locs = [{'BM'}; {'OHC'}; {'TM'}; {'EC'}]; % measurement locations
            locN = length(locs);       
            clrs = [{[28 82 172]/255}; {[237 118 194]/255}; {[255 148 0]/255}; {'r'}]; % plot colors
            mrks = [{'s'}; {'d'}; {'^'}; {'o'}]; % plot symbols
            mrksz = 9; % symbol size

            % Set up figure
            h=figure('units','normalized','position',[.3 .2 .173 .3]);
            ax1 = axes('position',[.15 .15 .75 .75], 'box', 'off', 'LineWidth', 1.4, 'FontSize', 15); hold on;
            
            xlim([27.5 77.5]); set(gca,'Xtick',0:10:100);
            ax1.XAxis.MinorTick = 'off';
            ax1.XAxis.MinorTickValues = 0:5:100;
            ax1.XAxis.TickLength = [.0125 .0125];
            
            ylim([0 3.5]); set(gca,'Ytick',0:1:10);
            ax1.YAxis.MinorTick = 'on';
            ax1.YAxis.MinorTickValues = 0:.5:10;
            ax1.YAxis.TickLength = [.0125 .0125];
            
            % Plot data for each location
            for loc_i = 1:locN
                loc = locs{loc_i}; % location
                clr = clrs{loc_i}; % color
                mrk = mrks{loc_i}; % symbol
                
                L1s = fig3.b.(genvarname(loc)).L1s; % stimulus levels
    
                % Get Q10dB values
                if strcmp(loc,'EC')
                    q10 = fig3.b.EC.mic.dp.q10;
                else
                    q10 = fig3.b.(genvarname(loc)).vib.f1.q10;
                end
                
               offset = rand(1)-.5; % symbol offset
               
                % Update symbol colors
                if strcmp(loc,'EC')
                    mrkclr = 'w';
                elseif strcmp(loc,'TM')
                    clr = [223 115 22]/255;
                    mrkclr = [255 148 0]/255;
                else
                    mrkclr = clr;
                end

               % Plot Q10dB vs. stimulus level
               if strcmp(loc,'TM')
                    plot(L1s, q10, '-','Color', mrkclr, 'LineWidth', 2);
                    plot(L1s, q10, 'LineStyle', 'none', 'Marker', mrk, 'Color', clr, 'LineWidth', 2,'Marker', mrk, 'MarkerFaceColor', mrkclr, 'MarkerSize', mrksz);
               else
                    plot(L1s, q10, '-','Color', clr, 'LineWidth', 2,'Marker', mrk, 'MarkerFaceColor', mrkclr, 'MarkerSize', mrksz);
               end
            end

        case 'c'
            %% Fig. 3C - Average Q10dB
            locs = [{'BM'}; {'OHC'}; {'TM'}; {'EC'}]; % measurement locations
            locN = length(locs);       
            clrs = [{[28 82 172]/255}; {[237 118 194]/255}; {[255 148 0]/255}; {'r'}]; % plot colors
            mrks = [{'s'}; {'d'}; {'^'}; {'o'}]; % plot symbols
            mrksz = 9; % symbol size

            % Set up figure
            h=figure('units','normalized','position',[.5 .2 .14 .3]);
            ax1 = axes('position',[.15 .15 .75 .75], 'box', 'off', 'LineWidth', 1.4, 'FontSize', 15); hold on;
            
            xlim([35 75]); set(gca,'Xtick',0:10:100);
            ax1.XAxis.MinorTick = 'off';
            ax1.XAxis.TickLength = [.0125 .0125];
            
            ylim([0 3.5]); set(gca,'Ytick',0:1:10);
            ax1.YAxis.MinorTick = 'on';
            ax1.YAxis.MinorTickValues = 0:.5:10;
            ax1.YAxis.TickLength = [.0125 .0125];
            
            % Plot data for each location
            for loc_i = 1:locN
                loc = locs{loc_i}; % location
                mrk = mrks{loc_i}; % symbol
                
                L1s = fig3.c.(genvarname(loc)).L1s; % stimulus levels

                % Get Ave and CI
                if strcmp(loc, 'EC')
                    q10_ave = fig3.c.EC.mic.dp.q10_ave;
                    q10_ci = fig3.c.EC.mic.dp.q10_ci;
                else
                    q10_ave = fig3.c.(genvarname(loc)).vib.f1.q10_ave;
                    q10_ci = fig3.c.(genvarname(loc)).vib.f1.q10_ci;
                end

                % Update symbol colors
                if strcmp(loc, 'EC')
                    clr = clrs{loc_i};
                    mrkClr = 'w';
                elseif strcmp(loc,'TM')
                    clr = [223 115 22]/255;
                    mrkClr = [255 148 0]/255;
                else
                    clr = clrs{loc_i};
                    mrkClr = clr;
                end

                offset = rand(1)-.5; 

                % Plot Average and CI
                errorbar(L1s + offset, q10_ave, q10_ci, 'LineStyle','none','Color', clr, 'LineWidth', 2);
                plot(L1s + offset, q10_ave, '-','Color', clr, 'LineWidth', 2);
                plot(L1s + offset, q10_ave, 'LineStyle','none','Color', clr, 'LineWidth', 2,'Marker', mrk, 'MarkerFaceColor', mrkClr, 'MarkerSize', mrksz);
            end

        case 'd'
            %% Fig. 3D - Average QERB
            locs = [{'BM'}; {'OHC'}; {'TM'}; {'EC'}]; % measurement locations
            locN = length(locs);       
            clrs = [{[28 82 172]/255}; {[237 118 194]/255}; {[255 148 0]/255}; {'r'}]; % plot colors
            mrks = [{'s'}; {'d'}; {'^'}; {'o'}]; % plot symbols
            mrksz = 9; % symbol size

            % Set up figure
            h=figure('units','normalized','position',[.66 .2 .14 .3]);
            ax1 = axes('position',[.15 .15 .75 .75], 'box', 'off', 'LineWidth', 1.4, 'FontSize', 15); hold on;
            
            xlim([35 75]); set(gca,'Xtick',0:10:100);
            ax1.XAxis.MinorTick = 'off';
            ax1.XAxis.TickLength = [.0125 .0125];
            
            ylim([.75 6]); set(gca,'Ytick',0:1:10);
            ax1.YAxis.MinorTick = 'on';
            ax1.YAxis.MinorTickValues = 0:.5:10;
            ax1.YAxis.TickLength = [.0125 .0125];
            
            % Plot data for each location
             for loc_i = 1:locN
                loc = locs{loc_i}; % location
                mrk = mrks{loc_i}; % symbol
                
                L1s = fig3.d.(genvarname(loc)).L1s;

                % Get Ave and CI
                if strcmp(loc, 'EC')
                    qerb_ave = fig3.d.EC.mic.dp.qerb_ave;
                    qerb_ci = fig3.d.EC.mic.dp.qerb_ci;
                else
                    qerb_ave = fig3.d.(genvarname(loc)).vib.f1.qerb_ave;
                    qerb_ci = fig3.d.(genvarname(loc)).vib.f1.qerb_ci;
                end
                
                % Update symbol colors
                if strcmp(loc, 'EC')
                    clr = clrs{loc_i};
                    mrkClr = 'w';
                elseif strcmp(loc,'TM')
                    clr = [223 115 22]/255;
                    mrkClr = [255 148 0]/255;
                else
                    clr = clrs{loc_i};
                    mrkClr = clr;
                end
                
                offset = rand(1)-.5; 

                % Plot Ave and CI
                errorbar(L1s + offset, qerb_ave, qerb_ci, 'LineStyle','none','Color', clr, 'LineWidth', 2);
                plot(L1s + offset, qerb_ave, '-','Color', clr, 'LineWidth', 2);
                plot(L1s + offset, qerb_ave, 'LineStyle','none','Color', clr, 'LineWidth', 2,'Marker', mrk, 'MarkerFaceColor', mrkClr, 'MarkerSize', mrksz);
             end
    end
end