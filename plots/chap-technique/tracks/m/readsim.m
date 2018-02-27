function [track,photon] = readsim(track_name, photon_name, event_num)
    
    % =====================================================================
    % Read the TRACK file 
    % =====================================================================
    disp(sprintf('Opening %s',track_name));
    fid=fopen(track_name,'r');

    disp(sprintf('Reading TRACK header'));
    
    line=0;
    line=fgets(fid);
    while((line~=-1)&(~strncmpi(line,'* dataf',7)))
        line=fgets(fid);
    end

    disp(sprintf('Reading TRACK events'));

    event=0;
    linecount=inf;
    where=ftell(fid);
    while((line~=-1)&(event<event_num))
        disp(sprintf('Event %d',event+1))
        where=ftell(fid);
        linecount=0;
        line=fgets(fid); % skip header

        line=fgets(fid);
        while((line~=-1)&(~strncmpi(line,'99',2)))
            linecount=linecount+1;
            line=fgets(fid);
        end
        event=event+1;
    end

    if(line == -1)
        error(['Premature end of file reached reading' track_name])
    end
        
    fseek(fid,where,'bof');
    line=fgets(fid); % skip header
    
    [track, count] = fscanf(fid, '%i %f %f %f %f %f %f %f %f %f %f %f %f', ...
                            [13, linecount]);
    fclose(fid);
    track=track';
    
    % =====================================================================
    % Read the photon file
    % =====================================================================
    disp(sprintf('Opening %s',photon_name));
    fid=fopen(photon_name,'r');

    disp(sprintf('Reading PHOTON header'));
    
    line=fgets(fid);
    while((line~=-1)&(~strncmpi(line,'* dataf',7)))
        line=fgets(fid);
    end

    line=fgets(fid); % skip R header
    if(line == -1)
        error(['Premature end of file reached reading' photon_name])
    end

    disp(sprintf('Reading PHOTON events'));

    line=fgets(fid); % skip S header
    event=0;
    linecount=inf;
    where=ftell(fid);
    while((line~=-1)&(event<event_num))
        disp(sprintf('Event %d',event+1))
        where=ftell(fid);
        linecount=0;
        
        line=fgets(fid);
        while((line~=-1)&(~strncmpi(line,'S',1)))
            linecount=linecount+1;
            line=fgets(fid);
        end
        event=event+1;
    end

    fseek(fid,where,'bof');
    [photon, count] = fscanf(fid, '%*2s %f %f %f %f %f %f %f %d %d', ...
                            [9, linecount]);
    fclose(fid);
    photon=photon';
    